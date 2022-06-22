### Install stuff
brew install libvirt
brew install qemu

brew install cdrtools (For making cloud init iso's)

brew services start libvirt

Then you can use `virsh` for managing QEMU guests. Or you get https://mac.getutm.app/ and do it with a halfway decent GUI. 

### Adjusting memory for a guest

`virsh setmem <domain> xGB --config`

`virsh setmaxmem <domain< xGB --config`

Restart the guest. 

### Generating a UUID for a guest
Run `uuidgen`


### Check the guest block devices
`virsh domblklist <domain>`

### Access serial console
inside guest

`systemctl enable serial-getty@ttyS0.service`

`systemctl start serial-getty@ttyS0.service`

### Eject a CDROM
`virsh change-media <domain> <device> --eject` (e.g. `virsh change-media ubuntu sdb --eject`)

### Using qemu-system-x86_64 CLI directly
https://www.jwillikers.com/virtualize-ubuntu-desktop-on-macos-with-qemu

### Good tutorial on QEMU/libvirt
https://www.naut.ca/blog/2020/08/26/ubuntu-vm-on-macos-with-libvirt-qemu/

### Cloud-based images

1. Create the meta-data and user-data files (samples are the other files in this gist)
2. `mkisofs -output init.iso -volid cidata -joliet -rock {user-data,meta-data}`
3. `qemu-system-x86_64 -M accel=hvf --cpu host -hda ubuntu-18.04-server-cloudimg-amd64.img --cdrom init.iso -boot d -m 2048`

### Forwarding traffic to a guest via SSH tunnel

To forward a port, e.g. port 443 from the VM to port 8443 locally, run the following: `ssh -p 2222 -L8443:localhost:443 user@localhost`
