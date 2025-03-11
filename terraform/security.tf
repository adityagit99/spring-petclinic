resource "aws_security_group" "deploysecurityG" {
  vpc_id      = aws_vpc.deployvpc.id

ingress {
   from_port   =  22
   to_port     =  22
   protocol    =  "tcp"
   cidr_blocks =  ["0.0.0.0/0"]
}

ingress {
   from_port =  "*"
   to_port   =  "*"
   protocol  =  "tcp"
   cidr_blocks = ["0.0.0.0/0"]
}

egress {

from_port  = 0
to_port    = 0
protocol   = "-1"
cidr_blocks = ["0.0.0.0/0"]

}

  tags = {
    Name = "deploy-security-group-terraform"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "deploysgingress" {
#   security_group_id = aws_security_group.deploysecurityG.id
#   cidr_ipv4         = aws_vpc.deployvpc.cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_egress_rule" "deploysgegress" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

