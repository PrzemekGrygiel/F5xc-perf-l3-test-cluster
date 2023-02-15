resource "aws_instance" "pg-vpc2-vm1" {
# TBD
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.vm_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-allow-all-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-workload-az-a-subnet.id
  associate_public_ip_address          = true
  private_ip                           = "${var.pg_vpc2_az_a_workload_vm_ip}"
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-vpc1-az-a-vm2"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
sudo apt update
sudo apt install nginx wrk iperf3 -y 
echo -e "net.core.rmem_max = 33554432\nnet.core.wmem_max = 33554432\nnet.ipv4.tcp_rmem = 4096 87380 33554432\nnet.ipv4.tcp_wmem = 4096 65536 33554432\nnet.core.netdev_max_backlog = 300000\nfs.file-max = 1048576\nnet.ipv4.tcp_tw_recycle = 1\nnet.ipv4.tcp_tw_reuse = 1\n"   >>  /etc/sysctl.conf 
echo -e "*       soft    nofile  60000\n*       hard    nofile  120000" >> /etc/security/limits.conf
echo -e "worker_rlimit_nofile 60000;" >> /etc/nginx/nginx.conf
sed -i 's/worker_connections 20000;/worker_connections 20000;' /etc/nginx/nginx.conf
sed -i 's/768/20000/' /etc/nginx/nginx.conf
sysctl --system
sleep 10
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/responses_code.lua -O /root/responses_code.lua
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/135.html -O /var/www/html/135.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/15k.html -O /var/www/html/15k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/37k.html -O /var/www/html/37k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/91k.html -O /var/www/html/91k.html
sudo wget https://gist.githubusercontent.com/khaykov/a6105154becce4c0530da38e723c2330/raw/41ab415ac41c93a198f7da5b47d604956157c5c3/gistfile1.txt -O /var/www/html/1M.html
sudo systemctl enable nginx
sudo systemctl start nginx
echo $(uname -n) > /var/www/html/index.nginx-debian.html
EOF
}

resource "aws_instance" "pg-vpc2-vm2" {
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.vm_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-allow-all-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-workload-az-b-subnet.id
  associate_public_ip_address          = true
  private_ip                           = "${var.pg_vpc2_az_b_workload_vm_ip}"
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-vpc1-az-b-vm2"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
sudo apt update
sudo apt install nginx wrk iperf3 -y 
echo -e "net.core.rmem_max = 33554432\nnet.core.wmem_max = 33554432\nnet.ipv4.tcp_rmem = 4096 87380 33554432\nnet.ipv4.tcp_wmem = 4096 65536 33554432\nnet.core.netdev_max_backlog = 300000\nfs.file-max = 1048576\nnet.ipv4.tcp_tw_recycle = 1\nnet.ipv4.tcp_tw_reuse = 1\n"   >>  /etc/sysctl.conf 
echo -e "*       soft    nofile  60000\n*       hard    nofile  120000" >> /etc/security/limits.conf
echo -e "worker_rlimit_nofile 60000;" >> /etc/nginx/nginx.conf
sed -i 's/worker_connections 20000;/worker_connections 20000;' /etc/nginx/nginx.conf
sed -i 's/768/20000/' /etc/nginx/nginx.conf
sysctl --system
sleep 10
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/responses_code.lua -O /root/responses_code.lua
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/135.html -O /var/www/html/135.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/15k.html -O /var/www/html/15k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/37k.html -O /var/www/html/37k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/91k.html -O /var/www/html/91k.html
sudo wget https://gist.githubusercontent.com/khaykov/a6105154becce4c0530da38e723c2330/raw/41ab415ac41c93a198f7da5b47d604956157c5c3/gistfile1.txt -O /var/www/html/1M.html

sudo systemctl enable nginx
sudo systemctl start nginx
echo $(uname -n) > /var/www/html/index.nginx-debian.html
EOF
}

resource "aws_instance" "pg-vpc2-vm3" {
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.vm_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-allow-all-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-workload-az-c-subnet.id
  associate_public_ip_address          = true
  private_ip                           = "${var.pg_vpc2_az_c_workload_vm_ip}"
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-vpc1-az-c-vm2"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
sudo apt update
sudo apt install nginx wrk iperf3 -y 
echo -e "net.core.rmem_max = 33554432\nnet.core.wmem_max = 33554432\nnet.ipv4.tcp_rmem = 4096 87380 33554432\nnet.ipv4.tcp_wmem = 4096 65536 33554432\nnet.core.netdev_max_backlog = 300000\nfs.file-max = 1048576\nnet.ipv4.tcp_tw_recycle = 1\nnet.ipv4.tcp_tw_reuse = 1\n"   >>  /etc/sysctl.conf 
echo -e "*       soft    nofile  60000\n*       hard    nofile  120000" >> /etc/security/limits.conf
echo -e "worker_rlimit_nofile 60000;" >> /etc/nginx/nginx.conf
sed -i 's/worker_connections 20000;/worker_connections 20000;' /etc/nginx/nginx.conf
sed -i 's/768/20000/' /etc/nginx/nginx.conf
sysctl --system
sleep 10
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/responses_code.lua -O /root/responses_code.lua
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/135.html -O /var/www/html/135.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/15k.html -O /var/www/html/15k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/37k.html -O /var/www/html/37k.html
sudo wget https://raw.githubusercontent.com/PrzemekGrygiel/F5xc-perf-l3-test-single/main/html/91k.html -O /var/www/html/91k.html
sudo wget https://gist.githubusercontent.com/khaykov/a6105154becce4c0530da38e723c2330/raw/41ab415ac41c93a198f7da5b47d604956157c5c3/gistfile1.txt -O /var/www/html/1M.html

sudo systemctl enable nginx
sudo systemctl start nginx
echo $(uname -n) > /var/www/html/index.nginx-debian.html
EOF
}

resource "aws_instance" "pg-vpc2-jump" {
  ami                                  = data.aws_ami.ubuntu.id
  tenancy                              = "default"
  ebs_optimized                        = false
  disable_api_termination              = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "${var.jump_instance_type}"
  key_name                             = "${var.key_name}"
  monitoring                           = false
  vpc_security_group_ids               = [aws_security_group.pg-vpc2-external-sg.id]
  subnet_id                            = aws_subnet.pg-vpc2-external-subnet.id
  associate_public_ip_address          = true
  source_dest_check                    = false
  tags = {
    Name = "${var.projectPrefix}-vpc2-jump"
  }
  connection {
    user        = "ubuntu"
    private_key = "${var.key_path}"
  }
  user_data = <<EOF
#!/bin/bash
while ! ping -c 1 -n -w 1 8.8.8.8 &> /dev/null;do  printf "%c" "."; sleep 5; done
sudo apt update
sudo apt install nginx wrk iperf3 -y 
echo -e "net.core.rmem_max = 33554432\nnet.core.wmem_max = 33554432\nnet.ipv4.tcp_rmem = 4096 87380 33554432\nnet.ipv4.tcp_wmem = 4096 65536 33554432\nnet.core.netdev_max_backlog = 300000\nfs.file-max = 1048576\nnet.ipv4.tcp_tw_recycle = 1\nnet.ipv4.tcp_tw_reuse = 1\n"   >>  /etc/sysctl.conf 
echo -e "*       soft    nofile  60000\n*       hard    nofile  120000" >> /etc/security/limits.conf
echo -e "worker_rlimit_nofile 60000;" >> /etc/nginx/nginx.conf
sed -i 's/worker_connections 20000;/worker_connections 20000;' /etc/nginx/nginx.conf
sed -i 's/768/20000/' /etc/nginx/nginx.conf
sysctl --system
sudo systemctl enable nginx
sudo systemctl start nginx
echo $(uname -n) > /var/www/html/index.nginx-debian.html
EOF
}
