resource "aws_instance" "deployece2instance" {
  ami                     = "ami-0d682f26195e9ec0f"
  instance_type           = "t2.micro"
  key_name = aws_key_pair.deploy-pub-key.key_name
  subnet_id = aws_subnet.deploysubnet.id
  security_groups = [aws_security_group.deploysecurityG.id]

  provisioner "remote-exec" {
    inline = {
      "sudo apt update",
      "curl -fsSL https://get.docker.com -o install-docker.sh",
      "sudo sh install-docker.sh",
      "sudo docker info",
      "git clone https://github.com/adityagit99/spring-petclinic.git",
      "cd spring-petclinic",
      "ls -al",
      "docker image -t spc:1.0 .",
      "docker image ls",
      "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 688567298785.dkr.ecr.ap-south-1.amazonaws.com"
      "docker tag 688567298785.dkr.ecr.ap-south-1.amazonaws.com/development/cicdrepo:latest",
      "docker push 688567298785.dkr.ecr.ap-south-1.amazonaws.com/development/cicdrepo:latest"
    }
    
  }

}
  # connection {
  #   type     = "ssh"
  #   user     = "ubuntu"
  #   password = var.root_password
  #   host     = self.public_ip
  #   private_key = file("~/.ssh/id_rsa")
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "puppet apply",
  #     "consul join ${aws_instance.web.private_ip}",
  #   ]
  # }
