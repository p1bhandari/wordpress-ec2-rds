variable "region" {
  description = "region "
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "The VPC ID where WordPress will reside"
  default     = "vpc-00f4752312a6"
}

variable "subnet_group" {
  description = "subnet group for rds"
  default     = "rds-subnet1"
}

variable "subnet_public" {
  description = "The public subnet for the instance"
  default     = "subnet-070d8f98b836b0f93"
}
variable "sg" {
  description = "The security group for the instance"
  default     = "sg-0fccefb3f5aa0d3f8"
}

variable "ami_id" {
  description = "The ami id  for launch instance "
  default     = "ami-0b44050b2d893d5f7"

}

variable "instance_type" {
  description = "Instance type for the instance"
  default     = "t2.medium"
}

variable "volume_size" {
  description = "ebs volume size in GB for the instance"
  default     = 8
}

variable "key_name" {
  description = "The key pair for ssh"
  default     = "mum-key"
}

variable "ssh_port" {
  description = "The SSH port for the server"
  default     = 22
}

variable "http_port" {
  description = "The HTTP port for the server"
  default     = 80
}

variable "mysql_port" {
  description = "The MySQL port for the database"
  default     = 3306
}

variable "allocated_storage" {
  description = "The size in gb of database"
  default     = 10
}

variable "instance_class" {
  description = "type of the rds-sql instance"
  default     = "db.t2.micro"
}

variable "db_admin" {
  description = "dbadmin username"
  default     = "admin"
}

variable "db_password" {
  description = "dbadmin password"
  default     = "TestServer"
}

variable "db_name" {
  description = "The database name"
  default     = "wordpressdb"
}
