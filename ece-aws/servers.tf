resource "aws_instance" "ece" {
  ami           = "${var.aws-ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.aws_key_pair}"
  availability_zone =  "${var.az}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  tags {
    Name = "${var.username}-ece"
    owner = "${var.username}"
  }
  root_block_device {
    delete_on_termination = "true"
    volume_size = "${var.storage_size}"
  }
}

output "Public IP" {
  value = "${aws_instance.ece.public_ip}"
}