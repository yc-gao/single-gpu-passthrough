# isolate cpus & Huge Pages

```
# /boot/grub/grub.cfg
isolcpus=8-31 nohz_full=8-31 default_hugepagesz=1G hugepagesz=1G hugepages=40
```

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
chrt -r 1 \
    taskset -c 8-31 \
    qemu-system-x86_64 \
    -machine q35,accel=kvm \
    -cpu host \
    -smp cores=24 \
    -m 32G \
    -mem-path /dev/hugepages \
    -mem-prealloc \
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
    -o $PWD/out.log \
    -e $PWD/err.log \
    $PWD/win10 \
    --qemu "chrt -r 1 taskset -c 8-31 qemu-system-x86_64" \
    -smp cores=24 \
    -m 32G \
    -mem-path /dev/hugepages \
    -mem-prealloc \
    -nic user \
    -drive file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd,if=pflash,format=raw,readonly=on \
    -drive file=win10.img,if=virtio,media=disk,format=raw
```
