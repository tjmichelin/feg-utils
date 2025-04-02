#!/bin/bash
# Script para instalação de ferramentas comuns após instalação de um novo sistema (fresh install).
# Específico para computadores com arquitetura x86_64.
# Desenvolvido para ser utilizado em sistemas Linux Xubuntu.

# Remove unused programs
apt purge -y thunderbird gnome-sudoku gnome-mines sgt-puzzles sgt-launcher hexchat mousepad atril
apt autoremove -y

apt update

# Install some basic tools
apt install -y gpg vim gedit evince wget apt-transport-https net-tools curl build-essential

# Install a better looking theme :-)
apt install -y arc-theme

# Install Arduino IDE 2.x
LATEST_RELEASE_URL=https://github.com/arduino/arduino-ide/releases/latest
FINAL_URL=$(curl -Ls -o /dev/null -w '%{url_effective}' "$LATEST_RELEASE_URL")
VERSION=$(echo "$FINAL_URL" | awk -F'/' '{print $NF}')

DOWNLOAD_URL="https://github.com/arduino/arduino-ide/releases/download/${VERSION}/arduino-ide_${VERSION}_Linux_64bit.zip"

if [ -n "$SUDO_USER" ]; then
	HOME="/home/${SUDO_USER}"
else
	HOME=$HOME
fi
echo "Home is set to: ${HOME}"

cd ${HOME}/Downloads
wget $DOWNLOAD_URL
mkdir ./arduino
unzip arduino-ide_${VERSION}_Linux_64bit.zip -d arduino/
rm arduino-ide_${VERSION}_Linux_64bit.zip

mv arduino/ /opt/

chown -R root:root /opt/arduino
chmod 4755 /opt/arduino/chrome-sandbox

# Configuration to allow Arduino IDE access to the serial port
RULE_FILE=/etc/udev/rules.d/99-arduino.rules
touch $RULE_FILE
echo "SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2341\", GROUP=\"plugdev\", MODE=\"0666\"" >> $RULE_FILE

# Create menu entry
DESKTOP_FILE=/usr/share/applications/arduino-ide.desktop
touch $DESKTOP_FILE
cat <<EOL >> "$DESKTOP_FILE"
[Desktop Entry]
Version=$VERSION
Name=Arduino
Comment=Arduino IDE
Exec=/opt/arduino/arduino-ide
Icon=/opt/arduino/resources/app/resources/icons/512x512.png
Terminal=false
Type=Application
Categories=Development;IDE;
EOL

echo "Process finished."
echo "Remember to reboot system for changes to take effect"
