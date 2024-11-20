# Generate an SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key locally
resource "local_file" "ssh_private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "./ssh_key"
}

# Save the public key locally
resource "local_file" "ssh_public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "./ssh_key.pub"
}

# EC2 Key Pair resource to associate the public key with AWS
resource "aws_key_pair" "app_key" {
  key_name   = "app-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# EC2 Instances
resource "aws_instance" "app" {
  count           = var.instaces_number
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = var.ec2_instance_type
  subnet_id       = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.ec2_public_sg.id]
  key_name        = aws_key_pair.app_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "app-server-${count.index + 1}"
    Role = "AppServer"
  }

  lifecycle {
    ignore_changes = [
      security_groups,
      ami
    ]
  }

  provisioner "local-exec" {
    command = <<-EOT
      docker run --rm `
        -v "${path.cwd}/provisioning/deploy_flask_app.yml:/ansible/playbook.yml" `
        -v "${path.cwd}/ssh_key:/root/.ssh/id_rsa" `
        -e ANSIBLE_HOST_KEY_CHECKING=False `
        williamyeh/ansible:alpine3 `
        sh -c "chmod 600 /root/.ssh/id_rsa && ansible-playbook -i '${self.public_ip},' /ansible/playbook.yml -u ec2-user"
    EOT
    interpreter = ["powershell", "-Command"]
  }

  connection {
    type        = "ssh"
    user        = var.ec2_user
    private_key = tls_private_key.ssh_key.private_key_pem
    host        = self.public_ip
  }
}

resource "aws_instance" "load_balancer" {
  ami             = data.aws_ami.amazon_linux.id
  instance_type   = var.ec2_instance_type
  subnet_id       = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.ec2_public_sg.id]
  key_name        = aws_key_pair.app_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "load-balancer"
    Role = "LoadBalancer"
  }

  lifecycle {
    ignore_changes = [
      security_groups,
      ami
    ]
  }

  provisioner "local-exec" {
    command = <<-EOT
      docker run --rm `
        -v "${path.cwd}/provisioning/deploy_loadbalancer.yml:/ansible/playbook.yml" `
        -v "${path.cwd}/ssh_key:/root/.ssh/id_rsa" `
        -e ANSIBLE_HOST_KEY_CHECKING=False `
        -e APP_SERVER_IPS='${join(",", aws_instance.app[*].public_ip)}' `
        williamyeh/ansible:alpine3 `
        sh -c "chmod 600 /root/.ssh/id_rsa && ansible-playbook -i '${self.public_ip},' /ansible/playbook.yml -u ec2-user"
    EOT
    interpreter = ["powershell", "-Command"]
  }

  connection {
    type        = "ssh"
    user        = var.ec2_user
    private_key = tls_private_key.ssh_key.private_key_pem
    host        = self.public_ip
  }
}


resource "aws_eip" "app_eip" {
  count    = 2
  instance = aws_instance.app[count.index].id
  depends_on = [aws_instance.app]
}

resource "aws_eip" "load_balancer_eip" {
  instance = aws_instance.load_balancer.id
  depends_on = [aws_instance.load_balancer]
}
