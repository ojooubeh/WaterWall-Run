# WaterWall Setup Script

## Description

This script provides a comprehensive setup for WaterWall, including installation, update, and configuration options. It also includes server management functionalities such as DNS configuration and TCP optimization.

## Features

- Install and update WaterWall
- Change WaterWall configuration
- Start and stop WaterWall service
- Uninstall WaterWall
- Server management (DNS, BBR, optimization)
- Automatic download retry using WARP if initial download fails

## Installation

To install the script and its prerequisites, please refer to the [installation guide](INSTALL_en.md).

### Method 1: Download and Run with curl

```bash
sudo apt update && sudo apt install -y dos2unix curl git && curl -L https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -o install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
#Method 2: Download and Run with wget
```bash
sudo apt update && sudo apt install -y dos2unix wget git && wget https://raw.githubusercontent.com/ojooubeh/WaterWall-Run/main/install_waterwall.sh -O install_waterwall.sh && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
```
## Configuration

For detailed configuration options, please refer to the [configuration guide](CONFIG_en.md).

## Usage

Run the script and follow the on-screen instructions to manage WaterWall and server settings.

## Acknowledgements

This project builds upon the excellent work done by the [WaterWall project](https://github.com/radkesvat/WaterWall). Please refer to their [documentation](https://radkesvat.github.io/WaterWall-Docs/) for more details.

## Future Work

We aim to automate the configuration process in future updates.
