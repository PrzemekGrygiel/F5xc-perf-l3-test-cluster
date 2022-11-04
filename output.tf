output "pg-vpc1-vm1-Instance-ID" {
  value = "${aws_instance.pg-vpc1-vm1.id}"
}
output "pg-vpc1-vm1-Private-IP" {
  value = "${aws_instance.pg-vpc1-vm1.private_ip}"
}
output "pg-vpc1-vm1-Public-IP" {
  value = "${aws_instance.pg-vpc1-vm1.public_ip}"
}
output "pg-vpc1-vm2-Instance-ID" {
  value = "${aws_instance.pg-vpc1-vm2.id}"
}
output "pg-vpc1-vm2-Private-IP" {
  value = "${aws_instance.pg-vpc1-vm2.private_ip}"
}
output "pg-vpc1-vm2-Public-IP" {
  value = "${aws_instance.pg-vpc1-vm2.public_ip}"
}
output "pg-vpc1-vm3-Instance-ID" {
  value = "${aws_instance.pg-vpc1-vm3.id}"
}
output "pg-vpc1-vm3-Private-IP" {
  value = "${aws_instance.pg-vpc1-vm3.private_ip}"
}
output "pg-vpc1-vm3-Public-IP" {
  value = "${aws_instance.pg-vpc1-vm3.public_ip}"
}
output "pg-vpc1-VPC-ID" {
  value = "${aws_vpc.pg-vpc1.id}"
}


output "pg-vpc2-vm1-Instance-ID" {
  value = "${aws_instance.pg-vpc2-vm1.id}"
}
output "pg-vpc2-vm1-Private-IP" {
  value = "${aws_instance.pg-vpc2-vm1.private_ip}"
}
output "pg-vpc2-vm2-Instance-ID" {
  value = "${aws_instance.pg-vpc2-vm2.id}"
}
output "pg-vpc2-vm1-Public-IP" {
  value = "${aws_instance.pg-vpc2-vm1.public_ip}"
}
output "pg-vpc2-vm2-Private-IP" {
  value = "${aws_instance.pg-vpc2-vm2.private_ip}"
}
output "pg-vpc2-vm2-Public-IP" {
  value = "${aws_instance.pg-vpc2-vm2.public_ip}"
}
output "pg-vpc2-vm3-Instance-ID" {
  value = "${aws_instance.pg-vpc2-vm3.id}"
}
output "pg-vpc2-vm3-Private-IP" {
  value = "${aws_instance.pg-vpc2-vm3.private_ip}"
}
output "pg-vpc2-vm3-Public-IP" {
  value = "${aws_instance.pg-vpc2-vm3.public_ip}"
}
output "pg-vpc2-VPC-ID" {
  value = "${aws_vpc.pg-vpc2.id}"
}

output "pg-vpc1-jump-public-ip" {
    value = "${aws_instance.pg-vpc1-jump.public_ip}"
}

output "pg-vpc2-jump-public-ip" {
    value = "${aws_instance.pg-vpc2-jump.public_ip}"
}