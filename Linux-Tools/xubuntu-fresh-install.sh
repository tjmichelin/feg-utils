#!/bin/bash
# Script para instalação de ferramentas comuns após instalação de um novo sistema.
# Específico para computadores com arquitetura x86_64.
# Desenvolvido para ser utilizado em sistemas Linux baseados em Debian.

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
	HOME="/Users/${SUDO_USER}"
else
	HOME=$HOME
fi
echo "Home is set to: ${HOME}"

cd ${HOME}/Downloads
wget $DOWNLOAD_URL
mkdir arduino
unzip arduino-ide_${VERSION}_Linux_64bit.zip -d arduino/
rm arduino-ide_${VERSION}_Linux_64bit.zip

mv arduino/ /opt/

chown -R root:root /opt/arduino
chmod 4755 /opt/arduino/chrome-sandbox

RULE_FILE=/etc/udev/rules.d/99-arduino.rules
touch $RULE_FILE
echo "SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2341\", GROUP=\"plugdev\", MODE=\"0666\"" >> $RULE_FILE

PACKAGE_FILE=${HOME}/.arduino15/package_index.json

if [ -e "${PACKAGE_FILE}" ]; then
  cp ${PACKAGE_FILE} ${HOME}/.arduino15/library_index.json
else
  echo "Library json file not found."
fi

echo "Remember to reboot system for changes to take effect"