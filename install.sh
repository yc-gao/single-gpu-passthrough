#!/bin/bash

if [ -d /etc/libvirt/hooks ]; then
    echo 'Error: /etc/libvirt/hooks exists.'
    exit 1
fi


if [ -f /etc/systemd/system/libvirt-nosleep@.service ]; then
    echo 'Error: /etc/systemd/system/libvirt-nosleep@.service exists.'
    exit 1
fi

if [ ! -d /usr/share/vgabios/ ]; then
    mkdir -p /usr/share/vgabios/
fi

cp -r libvirt-hooks /etc/libvirt/hooks
cp libvirt-nosleep@.service /etc/systemd/system/libvirt-nosleep@.service 
cp rom/* /usr/share/vgabios/

