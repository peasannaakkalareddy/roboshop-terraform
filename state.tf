terraform {
  backend "s3" {
    bucket = "akp999"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
