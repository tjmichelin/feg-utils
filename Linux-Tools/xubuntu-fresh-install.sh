#!/bin/bash

# Remove unused programs
apt purge -y thunderbird gnome-sudoku gnome-mines sgt-puzzles sgt-launcher hexchat mousepad atril
apt autoremove -y

apt update

# Install some basic tools
apt install -y gpg vim gedit evince wget apt-transport-https net-tools curl build-essential

# Install a better theme :-)
apt install -y arc-theme

# Install Arduino IDE 2.x
LATEST_RELEASE_URL=https://github.com/arduino/arduino-ide/releases/latest
FINAL_URL=$(curl -Ls -o /dev/null -w '%{url_effective}' "$LATEST_RELEASE_URL")
VERSION=$(echo "$FINAL_URL" | awk -F'/' '{print $NF}')

DOWNLOAD_URL="https://github.com/arduino/arduino-ide/releases/download/$VERSION/arduino-ide_$VERSION_Linux_64bit.zip"

cd $HOME/Downloads
wget $DOWNLOAD_URL
mkdir arduino
unzip arduino-ide_$VERSION_Linux_64bit.zip -d arduino/

mv arduino/ /opt/

chown -R root:root /opt/arduino
chmod 4755 /opt/arduino/chrome-sandbox

RULE_FILE=/etc/udev/rules.d/99-arduino.rules
touch $RULE_FILE
echo "SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"2341\", GROUP=\"plugdev\", MODE=\"0666\"" >> $RULE_FILE

cp $HOME/.arduino15/package_index.json $HOME/.arduino15/library_index.json
