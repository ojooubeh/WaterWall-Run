# Configuration Guide

## Changing WaterWall Configuration

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

## Server Management Options

### DNS Configuration

You can change the DNS settings to Google, Cloudflare, or reset to default:

- **Change DNS to Google:**
    ```plaintext
    11. Change DNS to Google
    ```

- **Change DNS to Cloudflare:**
    ```plaintext
    12. Change DNS to Cloudflare
    ```

- **Reset DNS to default:**
    ```plaintext
    13. Reset DNS to default
    ```

### BBR (TCP Optimization)

You can install or remove BBR for TCP optimization:

- **Install BBR:**
    ```plaintext
    8. Install BBR
    ```

- **Remove BBR:**
    ```plaintext
    9. Remove BBR
    ```

### Server Optimization

You can optimize the server by installing and starting `haveged`:

- **Optimize server:**
    ```plaintext
    10. Optimize server
    ```

For detailed configuration options, please refer to the [WaterWall documentation](https://radkesvat.github.io/WaterWall-Docs/).
