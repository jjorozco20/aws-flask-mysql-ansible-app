output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "db_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

# Output public IPs of all EC2 instances
output "ec2_public_ips" {
  value = [for instance in aws_instance.app : instance.public_ip]
}

# Output public IPs of all EC2 instances
# output "lb_public_ip" {
#   value = aws_instance.load_balancer.public_ip
# }

# Output the public key file path
output "ssh_public_key_file" {
  description = "Path to the public SSH key file"
  value       = local_file.ssh_public_key.filename
}

# Output the public key content
output "ssh_public_key" {
  description = "Public SSH key content"
  value       = tls_private_key.ssh_key.public_key_openssh
}

# Output the private key content (optional, use with caution)
output "ssh_private_key" {
  description = "Private SSH key content (use only if absolutely needed)"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
