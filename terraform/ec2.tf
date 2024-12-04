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
  count           = 2
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = var.ec2_instance_type
  subnet_id       = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.ec2_public_sg.id]
  key_name        = aws_key_pair.app_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.volume_size
  }

  depends_on = [aws_db_instance.mysql]

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
      sleep 60
      export ANSIBLE_HOST_KEY_CHECKING=False
      export DB_ENDPOINT="${aws_db_instance.mysql.endpoint}"
      chmod 600 ${path.cwd}/ssh_key
      ansible-playbook -i '${self.public_ip},' ${path.cwd}/provisioning/deploy_docker.yml --private-key ${path.cwd}/ssh_key -u ec2-user
    EOT
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
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
