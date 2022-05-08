data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = var.public_key
}

resource "aws_instance" "tailscale" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.ssh_key.key_name
  security_groups             = [aws_security_group.allow_all.id]
  subnet_id                   = aws_subnet.my_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "tailscale"
  }
  provisioner "remote-exec" {
    inline = [
      "hostnamectl"
    ]
    connection {
      host        = aws_instance.tailscale.public_ip
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.ssh_key_path)
    }
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ssh_user} -i '${aws_instance.tailscale.public_ip},' --private-key ${var.ssh_key_path} playbook.yml"
  }
}

output "instance_connection" {
  value = "ssh -o 'UserKnownHostsFile=/dev/null' -i ~/.ssh/id_rsa_tf ubuntu@${aws_instance.tailscale.public_ip}"
}