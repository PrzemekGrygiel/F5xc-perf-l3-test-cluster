#!/bin/bash
WORKLOAD=$(terraform output --raw pg-vpc2-vm3-Private-IP)
JUMPHOST=$(terraform output --raw pg-vpc2-jump-public-ip)
ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o "StrictHostKeyChecking=no" -i ~/Documents/keys/aws/przemek-oregon.pem -W %h:%p ubuntu@$JUMPHOST" -i ~/Documents/keys/aws/przemek-oregon.pem ubuntu@$WORKLOAD $@ 

