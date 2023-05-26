resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = var.app_type == "app" ? local.app_tags : local.db_tags
}

resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance, aws_route53_record.record ]
  triggers = {
    private_ip = aws_instance.instance.private_ip
  }
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}


resource "aws_route53_record" "record" {
  zone_id = "Z0299491JAQ87HTY8OKC"
  name    = "${var.component_name}-dev.cskvsmi.online"
  type    = "A"
  ttl     = 30
  records = [ aws_instance.instance.private_ip ]
}

