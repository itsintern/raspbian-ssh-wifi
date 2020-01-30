#!/bin/sh

. secret

echo ""
echo "This script will enable sshd and wifi on a fresh raspbian image."
echo "Please flash the disk with Etcher, pull out the drive and push it back in. Press enter to continue."
read

TARGET=/Volumes/boot

if [[ -d $TARGET ]] ; then
    echo "Target: $TARGET"
else
    echo "Target: $TARGET not found!" > /dev/stderr
    exit 1
fi

echo "Enabling sshd"
touch /Volumes/boot/ssh

echo "Adding wifi configuration"
cat > /Volumes/boot/wpa_supplicant.conf << EOF 

country=de
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 scan_ssid=1
 ssid="$SSID"
 psk="$PSK"
}

EOF

sudo diskutil unmount /Volumes/boot
sudo diskutil eject /dev/disk2

echo ""
echo "The drive is now ready."

