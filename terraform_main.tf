resource "aws_instance" "webServer" {
  ami           = "amZi-04b70fa74e45c3917"
  instance_type = "t2.micro"
  tags = {
    Name = "web server - terraform"
  }
  user_data              = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo snap install docker
        sudo systemctl start docker
  EOF

  provisioner "remote-exec" {
    inline = [ "sudo apt update","sudo snap install docker",
    "sudo docker run -p 80:8080 -p 50000:50000 -d jenkins/jenkins" ]
  }
connection {
  type = "ssh"
  host = self.public_ip
  user = "ubuntu"
  private_key = file("/Users/hothaifa/downloads/DevSecOps.pem")
}

  key_name               = "DevSecOps"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]
}

resource "aws_security_group" "ssh-sg" {
  name        = "ssh-access"
  description = "allow ssh access"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
