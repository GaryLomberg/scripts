#!/bin/env bash


# Define tmux session name and window names
project_name=$1

session_name="$1_session"
run_window="run_window"
aux_window="aux_window"

# Start a new tmux session in detached mode
tmux new-session -d -s "$session_name" -n "$run_window"

# Split the window vertically
tmux split-window -h

# Run the shell in the first pane
tmux send-keys -t "$session_name:$run_window.0" "source dj_manage $project_name 'runserver 0:8000'" C-m

tmux send-keys -t "$session_name:$run_window.1" "source dj_manage $project_name shell_plus" C-m

tmux send-keys -t "$session_name:$run_window.0" "" C-m

# Create window for auxilliary runners
tmux new-window -t "$session_name" -n "$aux_window"

# Split the window vertically
tmux split-window -h

tmux send-keys -t "$session_name:$aux_window.0" "source tw_start base_camp" C-m

tmux send-keys -t "$session_name:$aux_window.1" "source dj_manage $project_name qcluster" C-m

# # Attach to the session
tmux attach -t "$session_name:$run_window.0"

