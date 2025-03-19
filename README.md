# Docker WG-Easy Setup Script

This script automates the installation of Docker and WG-Easy on Ubuntu. It handles all necessary steps, including updating packages, installing Docker, configuring WG-Easy, and displaying login credentials.

## Prerequisites

* Ubuntu operating system
* Root or sudo privileges

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/vini4huk/Wireduard_WebPanel.git
    cd Wireduard_WebPanel
    ```

2.  **Make the script executable:**

    ```bash
    chmod +x install_wg_easy.sh
    ```

3.  **Run the script:**

    ```bash
    sudo ./install_wg_easy.sh
    ```

    The script will prompt you to enter a password for WG-Easy.

## What the Script Does

* Updates the package list and upgrades existing packages.
* Installs required packages (ca-certificates, curl, gnupg, apt-transport-https).
* Adds the official Docker GPG key and repository.
* Installs Docker CE, Docker CLI, and containerd.io.
* Enables and starts the Docker service.
* Adds the current user to the `docker` group.
* Retrieves the external IP address of the host.
* Prompts the user for a password for WG-Easy.
* Runs the WG-Easy Docker container with the provided password and host IP.
* Displays the login details (host and password).

## Usage

After the script completes, you can access the WG-Easy web interface using the provided login details:

* **Host:** `your_external_ip:51821`
* **Password:** The password you entered during the script execution.

Open a web browser and navigate to the provided host address. Log in using the displayed password.

## Important Notes

* Ensure that ports 51820 (UDP) and 51821 (TCP) are open in your firewall.
* This script assumes you are running Ubuntu.
* After the script has run, you will need to log out and log back in, or run `newgrp docker` in your current shell, in order for the docker group changes to take effect.
* The WireGuard configuration files will be located in the `~/.wg-easy` directory.
* The script uses `ifconfig.me` to retrieve the external IP address. Make sure this service is accessible.
* This script installs the latest stable version of Docker and the latest version of `weejewel/wg-easy`.

## Contributing

Feel free to contribute to this project by submitting pull requests or opening issues.

## License

This project is licensed under the MIT License.
