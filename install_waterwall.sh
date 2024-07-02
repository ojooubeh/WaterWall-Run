#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variable to store the report
REPORT=""

# Function to clear the terminal and display welcome message
clear_terminal() {
    clear
    echo -e "${YELLOW}============================="
    echo " Welcome to WaterWall Setup "
    echo -e "============================= ${NC}"
    echo -e "${CYAN}GitHub ID: ojooubeh${NC}"
    echo ""
}

# Function to display installation menu
display_menu() {
    local current_version=$(get_installed_version)
    local latest_version=$(get_latest_github_version)
    local service_status=$(get_service_status)

    clear_terminal
    echo -e "${BLUE}===== WaterWall Management Menu =====${NC}"
    echo -e "${GREEN}WaterWall is installed in: /opt/WaterWall${NC}"
    echo -e "${GREEN}Current version: ${current_version}${NC}"
    echo -e "${GREEN}Latest version available on GitHub: ${latest_version}${NC}"
    echo -e "${GREEN}Service status: ${service_status}${NC}"
    echo -e "${CYAN}====================================${NC}"
    echo -e "${YELLOW}1. Install WaterWall${NC}"
    echo -e "${YELLOW}2. Update WaterWall${NC}"
    echo -e "${YELLOW}3. Change WaterWall configuration${NC}"
    echo -e "${YELLOW}4. Uninstall WaterWall${NC}"
    echo -e "${YELLOW}5. Stop WaterWall service${NC}"
    echo -e "${YELLOW}6. Start WaterWall service${NC}"
    echo -e "${CYAN}=== Server Management ===${NC}"
    echo -e "${YELLOW}7. Update and upgrade the server${NC}"
    echo -e "${YELLOW}8. Install BBR${NC}"
    echo -e "${YELLOW}9. Remove BBR${NC}"
    echo -e "${YELLOW}10. Optimize server${NC}"
    echo -e "${YELLOW}11. Change DNS to Google${NC}"
    echo -e "${YELLOW}12. Change DNS to Cloudflare${NC}"
    echo -e "${YELLOW}13. Reset DNS to default${NC}"
    echo -e "${YELLOW}14. Exit${NC}"
    echo -e "${CYAN}Enter your choice:${NC} "
}

# Function to install prerequisites
install_prerequisites() {
    echo "Checking and installing prerequisites..."

    # Check and install curl
    if ! dpkg -l | grep -q curl; then
        echo "Installing curl..."
        sudo apt-get install -y curl
    else
        echo "curl is already installed."
    fi

    # Check and install unzip
    if ! dpkg -l | grep -q unzip; then
        echo "Installing unzip..."
        sudo apt-get install -y unzip
    else
        echo "unzip is already installed."
    fi

    echo -e "${GREEN}Prerequisites checked and installed successfully.${NC}"
    REPORT+="Install prerequisites: Success\n"
}

# Function to create or update core.json
create_or_update_core_json() {
    local core_json_path="/opt/WaterWall/core.json"
    cat <<EOF > $core_json_path
{
    "log": {
        "path": "log/",
        "core": {
            "loglevel": "DEBUG",
            "file": "core.log",
            "console": true
        },
        "network": {
            "loglevel": "DEBUG",
            "file": "network.log",
            "console": true
        },
        "dns": {
            "loglevel": "SILENT",
            "file": "dns.log",
            "console": false
        }
    },
    "dns": {},
    "misc": {
        "workers": 0,
        "ram-profile": "server",
        "libs-path": "libs/"
    },
    "configs": [
        "config.json"
    ]
}
EOF
    echo -e "${GREEN}core.json created/updated successfully.${NC}"
    REPORT+="Create/Update core.json: Success\n"
}

# Function to install WaterWall
install_waterwall() {
    echo "Checking for the latest version..."

    # Get the latest version from GitHub
    local latest_version=$(curl -s https://api.github.com/repos/radkesvat/WaterWall/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    if [ -z "$latest_version" ]; then
        echo -e "${RED}Failed to fetch the latest version from GitHub.${NC}"
        REPORT+="Install WaterWall: Failed to fetch the latest version from GitHub.\n"
        return
    fi

    # Replace with actual download URL
    DOWNLOAD_URL="https://github.com/radkesvat/WaterWall/releases/download/$latest_version/Waterwall-linux-64.zip"

    # Download latest version and install
    echo "Downloading WaterWall from GitHub..."
    curl -sSL $DOWNLOAD_URL -o /tmp/Waterwall-latest.zip
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to download WaterWall from GitHub.${NC}"
        read -p "Do you want to try using WARP to bypass restrictions? (y/n): " use_warp
        if [ "$use_warp" = "y" ]; then
            echo -e "${YELLOW}Trying to use WARP...${NC}"
            sudo apt update
            sudo apt install -y curl
            curl -fsSL https://pkg.cloudflareclient.com/install.sh | sudo bash
            sudo apt install -y cloudflare-warp
            sudo warp-cli register
            sudo warp-cli set-mode proxy
            sudo warp-cli connect
            echo "Downloading WaterWall from GitHub using WARP..."
            curl -sSL $DOWNLOAD_URL -o /tmp/Waterwall-latest.zip
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to download WaterWall from GitHub even with WARP.${NC}"
                sudo warp-cli disconnect
                REPORT+="Install WaterWall: Failed to download WaterWall from GitHub.\n"
                return
            fi
            sudo warp-cli disconnect
        else
            REPORT+="Install WaterWall: Failed to download WaterWall from GitHub.\n"
            return
        fi
    fi

    if [ -f /tmp/Waterwall-latest.zip ]; then
        echo "File downloaded successfully."
    else
        echo -e "${RED}File download failed.${NC}"
        REPORT+="Install WaterWall: File download failed.\n"
        return
    fi

    echo "Unzipping WaterWall package..."
    sudo mkdir -p /opt/WaterWall
    sudo chown $USER:$USER /opt/WaterWall
    unzip -qo /tmp/Waterwall-latest.zip -d /opt/WaterWall
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to unzip WaterWall package.${NC}"
        REPORT+="Install WaterWall: Failed to unzip WaterWall package.\n"
        rm /tmp/Waterwall-latest.zip
        return
    fi
    rm /tmp/Waterwall-latest.zip

    # Set execute permissions for WaterWall binary
    chmod +x /opt/WaterWall/Waterwall

    # Check if the required file exists
    if [ ! -f /opt/WaterWall/Waterwall ]; then
        echo -e "${RED}Failed to install WaterWall. Executable not found.${NC}"
        REPORT+="Install WaterWall: Installation failed. Executable not found.\n"
        return
    fi

    # Create or update core.json
    create_or_update_core_json

    echo -e "${GREEN}WaterWall installed successfully.${NC}"
    REPORT+="Install WaterWall: Success\n"

    # Save installed version to a file
    echo "$latest_version" > /opt/WaterWall/version.txt

    # Prompt user to change configuration
    read -p "Do you want to change the configuration? (y/n): " change_config
    if [ "$change_config" = "y" ]; then
        change_waterwall_config
    else
        echo -e "${YELLOW}Skipping configuration change.${NC}"
        REPORT+="Change configuration: Skipped\n"
    fi

    # Prompt user to create service
    read -p "Do you want to create WaterWall service? (y/n): " create_service
    if [ "$create_service" = "y" ]; then
        create_waterwall_service
    else
        echo -e "${YELLOW}Skipping service creation. WaterWall installed without service.${NC}"
        REPORT+="Create service: Skipped\n"
    fi
}

# Function to update WaterWall
update_waterwall() {
    echo "Checking for updates..."

    # Get the latest version from GitHub
    local latest_version=$(curl -s https://api.github.com/repos/radkesvat/WaterWall/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    if [ -z "$latest_version" ]; then
        echo -e "${RED}Failed to fetch the latest version from GitHub.${NC}"
        REPORT+="Update WaterWall: Failed to fetch the latest version from GitHub.\n"
        return
    fi

    # Replace with actual download URL for updates
    DOWNLOAD_URL="https://github.com/radkesvat/WaterWall/releases/download/$latest_version/Waterwall-linux-64.zip"

    # Download latest version and install
    echo "Downloading WaterWall from GitHub..."
    curl -sSL $DOWNLOAD_URL -o /tmp/Waterwall-latest.zip
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to download WaterWall from GitHub.${NC}"
        read -p "Do you want to try using WARP to bypass restrictions? (y/n): " use_warp
        if [ "$use_warp" = "y" ]; then
            echo -e "${YELLOW}Trying to use WARP...${NC}"
            sudo apt update
            sudo apt install -y curl
            curl -fsSL https://pkg.cloudflareclient.com/install.sh | sudo bash
            sudo apt install -y cloudflare-warp
            sudo warp-cli register
            sudo warp-cli set-mode proxy
            sudo warp-cli connect
            echo "Downloading WaterWall from GitHub using WARP..."
            curl -sSL $DOWNLOAD_URL -o /tmp/Waterwall-latest.zip
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to download WaterWall from GitHub even with WARP.${NC}"
                sudo warp-cli disconnect
                REPORT+="Update WaterWall: Failed to download WaterWall from GitHub.\n"
                return
            fi
            sudo warp-cli disconnect
        else
            REPORT+="Update WaterWall: Failed to download WaterWall from GitHub.\n"
            return
        fi
    fi

    echo "Unzipping WaterWall package..."
    sudo mkdir -p /opt/WaterWall
    sudo chown $USER:$USER /opt/WaterWall
    unzip -qo /tmp/Waterwall-latest.zip -d /opt/WaterWall
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to unzip WaterWall package.${NC}"
        REPORT+="Update WaterWall: Failed to unzip WaterWall package.\n"
        rm /tmp/Waterwall-latest.zip
        return
    fi
    rm /tmp/Waterwall-latest.zip

    # Set execute permissions for WaterWall binary
    chmod +x /opt/WaterWall/Waterwall

    # Check if the required file exists
    if [ ! -f /opt/WaterWall/Waterwall ]; then
        echo -e "${RED}Failed to install WaterWall. Executable not found.${NC}"
        REPORT+="Update WaterWall: Installation failed. Executable not found.\n"
        return
    fi

    # Create or update core.json
    create_or_update_core_json

    echo -e "${GREEN}WaterWall updated successfully.${NC}"
    REPORT+="Update WaterWall: Success\n"

    # Save installed version to a file
    echo "$latest_version" > /opt/WaterWall/version.txt
}

# Function to change WaterWall configuration
change_waterwall_config() {
    echo -e "${CYAN}Change WaterWall configuration${NC}"
    nano /opt/WaterWall/config.json
    echo -e "${GREEN}Configuration changed successfully.${NC}"
    REPORT+="Change WaterWall configuration: Success\n"
}

# Function to uninstall WaterWall
uninstall_waterwall() {
    echo "Uninstalling WaterWall..."

    # Stop the service if running
    stop_waterwall_service

    # Remove the installation directory
    sudo rm -rf /opt/WaterWall
    echo -e "${GREEN}WaterWall uninstalled successfully.${NC}"
    REPORT+="Uninstall WaterWall: Success\n"

    # Remove the service
    sudo systemctl disable waterwall.service
    sudo rm /etc/systemd/system/waterwall.service
    sudo systemctl daemon-reload
    echo -e "${GREEN}WaterWall service removed successfully.${NC}"
    REPORT+="Remove WaterWall service: Success\n"
}

# Function to stop WaterWall service
stop_waterwall_service() {
    echo "Stopping WaterWall service..."
    sudo systemctl stop waterwall.service
    echo -e "${GREEN}WaterWall service stopped successfully.${NC}"
    REPORT+="Stop WaterWall service: Success\n"
}

# Function to start WaterWall service
start_waterwall_service() {
    echo "Starting WaterWall service..."
    sudo systemctl start waterwall.service
    echo -e "${GREEN}WaterWall service started successfully.${NC}"
    REPORT+="Start WaterWall service: Success\n"
}

# Function to update and upgrade the server
update_upgrade_server() {
    echo "Updating and upgrading the server..."
    sudo apt-get update && sudo apt-get upgrade -y
    echo -e "${GREEN}Server updated and upgraded successfully.${NC}"
    REPORT+="Update and upgrade the server: Success\n"
}

# Function to install BBR
install_bbr() {
    echo "Installing BBR..."
    sudo modprobe tcp_bbr
    echo "tcp_bbr" | sudo tee -a /etc/modules-load.d/modules.conf
    sudo sysctl -w net.core.default_qdisc=fq
    sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
    sudo sysctl -p
    echo -e "${GREEN}BBR installed successfully.${NC}"
    REPORT+="Install BBR: Success\n"
}

# Function to remove BBR
remove_bbr() {
    echo "Removing BBR..."
    sudo sed -i '/^tcp_bbr$/d' /etc/modules-load.d/modules.conf
    sudo sysctl -w net.ipv4.tcp_congestion_control=cubic
    sudo sysctl -p
    echo -e "${GREEN}BBR removed successfully.${NC}"
    REPORT+="Remove BBR: Success\n"
}

# Function to optimize server
optimize_server() {
    echo "Optimizing server..."
    sudo apt-get install -y haveged
    sudo systemctl start haveged
    echo -e "${GREEN}Server optimized successfully.${NC}"
    REPORT+="Optimize server: Success\n"
}

# Function to change DNS to Google
change_dns_google() {
    echo "Changing DNS to Google..."
    sudo sed -i '/^#DNS=/a DNS=8.8.8.8 8.8.4.4' /etc/systemd/resolved.conf
    sudo sed -i '/^#FallbackDNS=/a FallbackDNS=2001:4860:4860::8888 2001:4860:4860::8844' /etc/systemd/resolved.conf
    sudo systemctl restart systemd-resolved
    echo -e "${GREEN}DNS changed to Google successfully.${NC}"
    REPORT+="Change DNS to Google: Success\n"
}

# Function to change DNS to Cloudflare
change_dns_cloudflare() {
    echo "Changing DNS to Cloudflare..."
    sudo sed -i '/^#DNS=/a DNS=1.1.1.1 1.0.0.1' /etc/systemd/resolved.conf
    sudo sed -i '/^#FallbackDNS=/a FallbackDNS=2606:4700:4700::1111 2606:4700:4700::1001' /etc/systemd/resolved.conf
    sudo systemctl restart systemd-resolved
    echo -e "${GREEN}DNS changed to Cloudflare successfully.${NC}"
    REPORT+="Change DNS to Cloudflare: Success\n"
}

# Function to reset DNS to default
reset_dns_default() {
    echo "Resetting DNS to default..."
    sudo sed -i '/^DNS=/d' /etc/systemd/resolved.conf
    sudo sed -i '/^FallbackDNS=/d' /etc/systemd/resolved.conf
    sudo systemctl restart systemd-resolved
    echo -e "${GREEN}DNS reset to default successfully.${NC}"
    REPORT+="Reset DNS to default: Success\n"
}

# Function to get the installed version of WaterWall
get_installed_version() {
    if [ -f /opt/WaterWall/version.txt ]; then
        cat /opt/WaterWall/version.txt
    else
        echo "Not installed"
    fi
}

# Function to get the latest version from GitHub
get_latest_github_version() {
    local latest_version=$(curl -s https://api.github.com/repos/radkesvat/WaterWall/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    echo "$latest_version"
}

# Function to get the service status of WaterWall
get_service_status() {
    local service_status=$(sudo systemctl is-active waterwall.service)
    echo "$service_status"
}

# Function to create WaterWall service
create_waterwall_service() {
    echo "Creating WaterWall service..."

    sudo bash -c 'cat <<EOF > /etc/systemd/system/waterwall.service
[Unit]
Description=WaterWall Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/WaterWall
ExecStart=/opt/WaterWall/Waterwall
Restart=on-failure
RestartSec=10
ExecStartPre=/bin/sleep 5

[Install]
WantedBy=multi-user.target
EOF'

    sudo systemctl daemon-reload
    sudo systemctl enable waterwall.service
    sudo systemctl start waterwall.service

    echo -e "${GREEN}WaterWall service created and started successfully.${NC}"
    REPORT+="Create WaterWall service: Success\n"
}

# Function to ask user for return to menu or exit
ask_for_return_or_exit() {
    echo -e "${CYAN}Do you want to return to the menu or exit?${NC}"
    echo -e "${YELLOW}1. Return to menu${NC}"
    echo -e "${YELLOW}2. Exit${NC}"
    read choice
    case $choice in
        1) display_menu ;;
        2) echo -e "${CYAN}Exiting...${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid choice. Please try again.${NC}"; ask_for_return_or_exit ;;
    esac
}

# Main function
main() {
    clear_terminal
    install_prerequisites
    display_menu

    while true; do
        read choice
        case $choice in
            1) install_waterwall ;;
            2) update_waterwall ;;
            3) change_waterwall_config ;;
            4) uninstall_waterwall ;;
            5) stop_waterwall_service ;;
            6) start_waterwall_service ;;
            7) update_upgrade_server ;;
            8) install_bbr ;;
            9) remove_bbr ;;
            10) optimize_server ;;
            11) change_dns_google ;;
            12) change_dns_cloudflare ;;
            13) reset_dns_default ;;
            14) echo -e "${CYAN}Exiting...${NC}"; break ;;
            *) echo -e "${RED}Invalid choice. Please try again.${NC}" ;;
        esac
        ask_for_return_or_exit
    done

    # Display the final report
    echo -e "\n${CYAN}====== Report ======${NC}"
    echo -e "${REPORT}"
}

# Run the main function
main
