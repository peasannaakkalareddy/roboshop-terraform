
  data "aws_ami" "centos" {
  owners      = [973714476881]
  most_recent = true
  name_regex  = "centos-8-Devops-Practice"
}

data "aws_security_group" "allow_all" {
  name = "allow_all"
}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.small"
    }

    mongodb = {
    name = "mongodb"
    instance_type = "t3.small"
    }


    Catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
    }


    redis = {
    name = "redis"
    instance_type = "t3.small"
    }


    user = {
    name = "user"
    instance_type = "t3.small"
    }


    cart = {
    name = "cart"
    instance_type = "t3.small"
    }


    mysql = {
    name = "mysql"
    instance_type = "t3.small"
    }



    shipping = {
    name = "shipping"
    instance_type = "t3.small"
    }


    rabbitmq = {
    name = "rabbitmq"
    instance_type = "t3.small"
    }


    payment = {
    name = "payment"
    instance_type = "t3.small"
    }

  }
}
#1

    resource "aws_instance" "instance" {
      for_each = var.components
        ami      = data.aws_ami.centos.image_id
      instance_type = each.value["instance_type"]
      vpc_security_group_ids = [data.aws_security_group.allow_all.id]


      tags = {
        Name = each.value["name"]
      }
      }