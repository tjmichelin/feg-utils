# Connect to OpenVPN using Ubuntu Default Network Manager

(Should work for any Ubuntu-based Linux systems, with some small adjustments).

## Step 1: Install Necessary Packages
Before configuring the VPN, ensure that the required packages are installed:

1. Open the Terminal by pressing `Ctrl + Alt + T`
2. Update your package list:

```bash
sudo apt update
```

3. Install OpenVPN and the Network Manager OpenVPN plugin:

```
sudo apt install openvpn network-manager-openvpn network-manager-openvpn-gnome
```

## Step 2: Obtain Your OpenVPN Configuration Files

You'll need the `.ovpn` configuration file from your VPN provider, which contains the necessary
settings and certificates to establish the connection. You can get UNESP's `.ovpn` file at
[https://www2.unesp.br/Home/vpn-unesp/openvpn/unesp.ovpn](https://www2.unesp.br/Home/vpn-unesp/openvpn/unesp.ovpn).
Right click this link and select `Save Link As...`. Then save its content to a known location on
your computer.

## Step 3: Configure the VPN Connection

1. Click on the Network Manager icon in the system tray (near the clock).
2. Select "Network Manager" or "Network Connections" from the dropdown menu.
3. In the Network Settings window, navigate to the "VPN" section.
4. Click the `+` (Add) button to create a new VPN connection.
5. Choose "Import from file..." and navigate to the location where you saved your `.ovpn` file.
6. Select the `.ovpn` file and click "Open."

   Network Manager will attempt to import the settings from the file.

7. A configuration window will appear with the imported settings. Here, you can:

   - **General Tab**:
     - Optionally, check "Automatically connect to VPN when using this connection" if you want the VPN to connect automatically.

   - **VPN Tab**:
     - Ensure all fields are correctly populated based on the imported file.
     - If your provider requires a username and password:
       - Enter them in the respective fields.
       - To avoid entering the password every time, you can choose to save it.

8. After verifying all settings, click "Save" to finalize the VPN configuration.

## Step 4: Connect to the VPN

1. Click on the Network Manager icon in the system tray.
2. Hover over "VPN Connections" and select the VPN connection you just configured.
3. Network Manager will initiate the connection. Once connected, you'll see a lock or similar icon indicating an active VPN connection.

## Step 5: Verify the VPN Connection

To ensure your VPN connection is active and functioning correctly, try accessing UNESP's Intranet.
If you can normally get access to this system, your configuration is correct. Otherwise, there might
be some configuration issue. Double-check your VPN settings or check if your access to the vpn is
allowed by the institution.

By following these steps, you should be able to connect to UNESP's OpenVPN server using Ubuntu 24.04's Network Manager.
