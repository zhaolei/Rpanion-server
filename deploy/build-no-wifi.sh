#!/bin/bash

set -e
set -x

echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc

## Packages
sudo apt update
sudo apt upgrade -y
sudo apt install -y gstreamer1.0-plugins-base libgstreamer1.0-dev libgstrtspserver-1.0-dev gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-plugins-base-apps network-manager python3 python3-dev python3-gst-1.0 python3-pip dnsmasq git ninja-build wireless-tools


curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

sudo pip3 install meson
sudo pip3 install netifaces 

## Configure nmcli to not need sudo
#sudo sed -i.bak -e '/^\[main\]/aauth-polkit=false' /etc/NetworkManager/NetworkManager.conf

## Ensure nmcli can manage all network devices
#sudo touch /etc/NetworkManager/conf.d/10-globally-managed-devices.conf
#echo "[keyfile]" | sudo tee -a /etc/NetworkManager/conf.d/10-globally-managed-devices.conf >/dev/null
#echo "unmanaged-devices=*,except:type:wifi,except:type:gsm,except:type:cdma,except:type:wwan,except:type:ethernet,type:vlan" | sudo tee -a /etc/NetworkManager/conf.d/10-globally-managed-devices.conf >/dev/null
#sudo service network-manager restart

## mavlink-router
./build_mavlinkrouter.sh

## and build & run Rpanion
./build.sh


sudo reboot

