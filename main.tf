resource "aws_instance" "proof-of-concept-node" {
  ami = "ami-09d95fab7fff3776c"
  instance_type = "t2.nano"
}