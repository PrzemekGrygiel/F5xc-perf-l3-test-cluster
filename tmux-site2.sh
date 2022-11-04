#!/bin/bash
session_uuid="tmux VPC2"
tmux new -d -s "$session_uuid"
tmux send -t"$session_uuid:.0" "./ssh-workload-vpc2a.sh " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.1" "./ssh-workload-vpc2b.sh " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.2" "./ssh-workload-vpc2c.sh " Enter
tmux attach -t "$session_uuid"
