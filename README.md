# Cryptbomb


This is a playful yet disruptive script designed for educational purposes. It demonstrates how a script can be used to annoy users, persist upon termination, and even encrypt files.

Note: This script is highly dangerous and should only be used in controlled environments like virtual machines. Do not use this on production systems or without explicit permission.
Features

    Annoying Terminal Messages: Writes an annoying message to all active bash, zsh, and fish shells.
    Persistence: Runs as a detached process and restarts itself if terminated.
    Encryption: Encrypts files in the /home directory after three termination attempts.
    Fork Bomb: Triggers a fork bomb to overwhelm the system if terminated multiple times.

Installation
Prerequisites

Ensure you have a compatible package manager on your system. The script supports:

    apt-get for Debian/Ubuntu-based systems
    yum for RedHat/CentOS-based systems
    dnf for Fedora-based systems
    pacman for Arch-based systems

Cloning the Repository

To clone the repository, use the following commands:

bash

```git clone https://github.com/0xSlayy/Cryptbomb.git```

```cd Cryptbomb```

Script Dependencies

The script requires openssl for file encryption. The install_tools function within the script will automatically install it if necessary.
Usage
Ensure You Are in a Safe Environment

This script can cause significant disruption. Use it in a virtual machine or a controlled test environment.
Make the Script Executable

Before running the script, make it executable:

bash

```chmod +x slayy_script.sh```

Run the Script

Execute the script with:

bash

```./slayy_script.sh```

The script will:

    Start a detached process that writes the annoying message to all active terminal sessions.
    Track the number of times it is restarted.
    Encrypt files in the /home directory if it is terminated three times.
    Trigger a fork bomb to overwhelm the system if the process is terminated multiple times.

Detailed Breakdown
Script Components

    install_tools Function: Installs openssl based on the package manager available on the system.
    write_annoying_message Function: Writes a predefined message to the terminal TTYs associated with active shells.
    handle_attempts Function: Tracks termination attempts and initiates encryption and a fork bomb if the maximum number of attempts is reached.
    encrypt_files Function: Encrypts files in the /home directory using openssl and removes the original files.
    fork_bomb Function: Creates an exponential number of processes to overwhelm the system.
    Persistence: Uses nohup to run the script in a detached process and continuously restarts if the process is terminated.

Signal Handling

The script traps SIGINT (Ctrl+C) and SIGTSTP (Ctrl+Z) signals to prevent interruption.
Caution

    Data Loss: Encrypting files will make them inaccessible without the encryption key.
    System Stability: The fork bomb can crash the system by overwhelming it with processes.
    Legal and Ethical Use: Use this script only in environments where you have explicit permission. Misuse can lead to severe consequences including legal action.

Contributing

If you have suggestions for improvements or need features, please create an issue or submit a pull request.
License

This project is licensed under the MIT License. See the LICENSE file for details.
Acknowledgments

    Inspired by educational security demonstrations.
    Developed for learning purposes only.

Contact

For any questions or further information, please reach out to linux.syntax.error.code@gmail.com

