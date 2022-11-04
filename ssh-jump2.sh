JUMPHOST=$(terraform output --raw pg-vpc2-jump-public-ip)
ssh -o "StrictHostKeyChecking=no" -i ~/Documents/keys/aws/przemek-oregon.pem ubuntu@$JUMPHOST 
