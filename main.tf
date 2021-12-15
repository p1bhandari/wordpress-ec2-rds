data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["vpc-mumbai"]
  }
}
data "aws_security_group" "sg1" {
  filter {
    name   = "group-name"
    values = ["mum-pub-sec1"]
  }
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.selected.id}"]
  }
}
resource "aws_instance" "wordpress" {
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${data.aws_security_group.sg.id}"]
  subnet_id              = "${var.subnet_public}"
  key_name               = "${var.key_name}"
  user_data              = <<-EOF
        #! /bin/bash
        apt-get update -y
        apt install php php-mysql -y
        cd /tmp && wget https://wordpress.org/latest.tar.gz
        tar -xvf latest.tar.gz
        cp -R wordpress /var/www/html/
        chown -R www-data:www-data /var/www/html/wordpress/
        chmod -R 755 /var/www/html/wordpress/
        mkdir /var/www/html/wordpress/wp-content/uploads
        chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads/
        service apache2 restart
    EOF
  tags = {
    Name  = "WordPress-staging"
    Owner = "Pawan bhandari"
  }

}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.wordpress.id
}

resource "aws_db_instance" "WordPressdb" {
  identifier             = "wordpressdb"
  engine                 = "mysql"
  engine_version         = "5.7"
  allocated_storage      = "${var.allocated_storage}"
  instance_class         = "${var.instance_class}"
  vpc_security_group_ids = ["${data.aws_security_group.sg.id}"]
  db_subnet_group_name   = "${var.subnet_group}"
  name                   = "${var.db_name}"
  username               = "${var.db_admin}"
  password               = "${var.db_password}"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  tags = {
    Name = "WordPress DB"
  }
}
