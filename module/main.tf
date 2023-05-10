resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = var.component_name
  }
}

resource "null_resource" "provisioner" {

  depends_on = [aws_instance.instance, aws_route53_record.record ]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/peasannaakkalareddy/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh" ${var.password}
    ]
  }
}




resource "aws_route53_record" "record" {
  zone_id = "Z0299491JAQ87HTY8OKC"
  name    = "${var.component_name}-dev.cskvsmi.online"
  type    = "A"
  ttl     = 30
  records = [ aws_instance.instance.private_ip ]
}

