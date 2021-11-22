output public_dns {
  value       = aws_instance.web.public_dns
  description = "DNS da instância"
}