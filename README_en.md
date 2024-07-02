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

```bash
sudo apt install -y dos2unix git && git clone https://github.com/ojooubeh/WaterWall-Run.git && cd WaterWall-Run && dos2unix install_waterwall.sh && chmod +x install_waterwall.sh && ./install_waterwall.sh
