# AWS Credential
variable "access_key" {
  description = "AWS Access Key"
  default     = ""
}
variable "secret_key" {
  description = "AWS Secret Key"
  default     = ""
}
variable "key_name" {
  default = "przemek-oregon"
}
variable "key_path" {
  default = "/Users/grygiel/Documents/keys/aws/przemek-oregon.pem"
}

variable aws_instance_type {
  default = "c5n.2xlarge"
}

variable vm_instance_type {
  default = "c5n.4xlarge"
}

variable jump_instance_type {
  default = "t3.large"
}

variable projectPrefix {
  default = "pg-cluster-perf"
}

variable l3_mode {
  default = true
}

# AWS 
variable "aws_region" {
  default = "us-west-2"
}

# VPC configuration
variable "vpc1_cidr_block" {
  default = "10.130.0.0/16"
}
# VPC configuration
variable "vpc2_cidr_block" {
  default = "10.131.0.0/16"
}

variable pg_vpc1_az_a_workload_vm_ip {
  default = "10.130.1.100"
}
variable pg_vpc1_az_b_workload_vm_ip {
  default = "10.130.4.100"
}
variable pg_vpc1_az_c_workload_vm_ip {
  default = "10.130.7.100"
}

variable pg_vpc2_az_a_workload_vm_ip {
  default = "10.131.1.100"
}
variable pg_vpc2_az_b_workload_vm_ip {
  default = "10.131.4.100"
}
variable pg_vpc2_az_c_workload_vm_ip {
  default = "10.131.7.100"
}
