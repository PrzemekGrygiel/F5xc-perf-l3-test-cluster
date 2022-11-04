#!/bin/bash
session_uuid="tmux VPC1"
tmux new -d -s "$session_uuid"
tmux send -t"$session_uuid:.0" "./ssh-workload-vpc1a.sh " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.1" "./ssh-workload-vpc1b.sh " Enter
tmux splitw -t "$session_uuid:" 
tmux send -t"$session_uuid:.2" "./ssh-workload-vpc1c.sh " Enter
tmux attach -t "$session_uuid"
