provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "db" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"

    tags = {
      Name = "DB Server"
    }
}

resource "aws_instance" "web" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"

    depends_on = [aws_instance.db]
}


data "aws_instance" "dbsearch" {
  filter {
    name = "tag:Name"
    values = ["DB Server"]
  }
}
// ref (prem) - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance.html
output "dbservers" {
  value = data.aws_instance.dbsearch.availability_zone
}
