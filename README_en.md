# WaterWall Setup Script

## Description

This script is designed for tunneling servers to each other and supports a wide range of tunneling methods and capabilities, including:

- Port to Port Tunnel
- TLS Tunnel
- PreConnect Node
- HTTP2 Mux GRPC Nodes
- Reverse Tunnel
- Reality Direct Tunnel
- Reality Reverse Tunnel
- BGP4 Tunnel or Direct
- Direct Trojan Protocol with Anti TLS in TLS
- HalfDuplex Tunnel or Direct
- Load Balancing
- CDN Tunnel Direct or Reverse
- Free Bind Connection

It provides a comprehensive setup for WaterWall, including installation, update, and configuration options. It also includes server management functionalities such as DNS configuration and TCP optimization.

## Features

- Install and update WaterWall
- Change WaterWall configuration
- Start and stop WaterWall service
- Uninstall WaterWall
- Server management (DNS, BBR, optimization)
- Automatic download retry using WARP if initial download fails

## Installation

To install the script, use one of the following methods:

### Method 1: Download and Run with curl

```bash
sudo apt update && sudo apt install -y dos2unix curl git && curl -L https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -o install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
#Method 2: Download and Run with wget
```bash
sudo apt update && sudo apt install -y dos2unix wget git && wget https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -O install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
## Configuration

For detailed configuration options, please refer to the [WaterWall documentation](https://radkesvat.github.io/WaterWall-Docs/). Depending on your tunneling method, complete the configuration file as per the instructions provided in the WaterWall documentation. You can find the relevant sections in the script where you need to make these configurations.

### Changing WaterWall Configuration

You can change the WaterWall configuration by selecting the appropriate option from the menu:

1. Run the script:
    ```bash
    ./install_waterwall.sh
    ```
2. Select the option to change the configuration:
    ```plaintext
    3. Change WaterWall configuration
    ```
3. The script will open the `config.json` file in a text editor. Make the necessary changes and save the file.

## Acknowledgements

This project builds upon the excellent work done by the [WaterWall project](https://github.com/radkesvat/WaterWall). Please refer to their [documentation](https://radkesvat.github.io/WaterWall-Docs/) for more details.

## Future Work

We aim to automate the configuration process in future updates.
