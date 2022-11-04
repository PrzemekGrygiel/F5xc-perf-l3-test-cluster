#!/bin/bash
JUMPHOST=$(terraform output --raw pg-vpc2-jump-public-ip)
for i in 1 2 3; do
    WORKLOAD=$(terraform output --raw pg-vpc2-vm$i-Private-IP)
    ssh -o "StrictHostKeyChecking=no" -o ProxyCommand="ssh -o "StrictHostKeyChecking=no" -i ~/Documents/keys/aws/przemek-oregon.pem -W %h:%p ubuntu@$JUMPHOST" -i ~/Documents/keys/aws/przemek-oregon.pem ubuntu@$WORKLOAD iperf3 -s -D
done
JUMPHOST=$(terraform output --raw pg-vpc1-jump-public-ip)
CLIENT1=$(terraform output --raw pg-vpc2-vm1-Private-IP)
CLIENT2=$(terraform output --raw pg-vpc2-vm2-Private-IP)
CLIENT3=$(terraform output --raw pg-vpc2-vm3-Private-IP)
session_uuid="iperf test"
tmux new -d -s "$session_uuid"
tmux send -t"$session_uuid:.0" "./ssh-workload-vpc1a.sh " Enter  "iperf3 -c $CLIENT1 -P 64 -t 30 " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.1" "./ssh-workload-vpc1b.sh " Enter "iperf3 -c $CLIENT2 -P 64 -t 30 " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.2" "./ssh-workload-vpc1c.sh " Enter "iperf3 -c $CLIENT3 -P 64 -t 30 " Enter
tmux attach -t "$session_uuid"
