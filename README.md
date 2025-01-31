```shell
pamcan -S --noconfirm edk2-ovmf virt-manager qemu-full
yay -S --noconfirm daemonize
```

```shell
qemu-system-x86_64 \
    -machine q35,accel=kvm
    -cpu host
    -smp cores=32
    -m 48G \
    -nic user \
    -cdrom ./win10.iso \
    -cdrom ./virtio.iso \
    -drive file=/dev/loop0,if=virtio,media=disk,format=raw
```

```shell
sudo daemonize \
    -v \
    -c $PWD \
    -o log/out.log \
    -e log/err.log \
    ./win10 \
    -drive file=/dev/loop0,if=virtio,media=disk,format=raw
```
