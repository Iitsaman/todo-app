output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = [for i in aws_instance.my_instance : i.id]
}

output "public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = [for i in aws_instance.my_instance : i.public_ip]
}

output "private_ips" {
  description = "Private IPs of the EC2 instances"
  value       = [for i in aws_instance.my_instance : i.private_ip]
}

output "security_group_id" {
  description = "ID of the security group created"
  value       = aws_security_group.my_sg.id
}

output "public_dns" {
  value = aws_instance.my_instance[*].public_dns
}








/*

output "instances_id" {
    value = [for instance in aws_instance.my_instance : instance.id]
    description = "this is id of ec2"
  
}


output "public_ip" {
    description = "this is public ip of ec2"
    value = [for instance in aws_instance.my_instance : instance.public_ip]
  
}


output "backend_public_dns" {
    value = aws_instance.my_instance[*].public_dns 
  
}

*/