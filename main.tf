resource "aws_instance" "prometheus" {
  ami =  var.ami
  vpc_security_group_ids = "var.vpc_security_group_ids"
  subnet_id = var.subnet_id
  instance_type = "t2.micro"

  user_data = file("promethues.sh")
  iam_instance_profile = aws_iam_instance_profile.prometheus_instance_profile.name
  tags = {
    Name = "prometheus"
  }

  depends_on = [aws_instance.node_exporter]

}

resource "aws_instance" "node_exporter" {
  ami = var.ami
  vpc_security_group_ids = "var.vpc_security_group_ids"
  subnet_id = var.subnet_id
  instance_type = "t2.micro"

  user_data = file("node_exporter.sh")
  
  tags = {
    Name = "node_exporter"
    Monitering: "true" 
  }
}

resource "aws_security_group" "prometheus" {
  name = "prometheus"
  description = "Allow TLS inbound and outbound all traffic"

  ingress = {
    from_port = 0 
    to_port = 0 
    protocal = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress = {
    from_port = 0 
    to_port = 0
    protocal = "-1" 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prometheus"
  }
}