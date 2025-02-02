# nvidia config
```
# /etc/modprobe.d/nvidia.conf
options nvidia_drm modeset=0 fbdev=0
```

# packages

```shell
sudo pacman -S --noconfirm edk2-ovmf libvirt qemu-full
yay -S --noconfirm daemonize
```

# libvirt config

```
# /etc/libvirt/libvirtd.conf

unix_sock_group = "libvirt"
unix_sock_ro_perms = "0777"  # set to 0770 to deny non-group libvirt users
unix_sock_rw_perms = "0770"
```

```shell
sudo systemctl enable libvirtd.service
```

# qemu commands

```shell
qemu-system-x86_64 \
    -machine q35,accel=kvm \
    -cpu host \
    -smp cores=32 \
    -m 48G \
    -nic user \
    -drive file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd,if=pflash,format=raw,readonly=on \
    -drive file=win10.iso,media=cdrom \
    -drive file=virtio.iso,media=cdrom \
    -drive file=win10.img,if=virtio,media=disk,format=raw
```

```shell
sudo daemonize \
    -v \
    -c $PWD \
    -o $PWD/log/out.log \
    -e $PWD/log/err.log \
    $PWD/win10 \
    -drive file=win10.img,if=virtio,media=disk,format=raw
```
