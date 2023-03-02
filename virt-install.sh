#Phase 1 script for installing QEMU onto any arch-based distro with SystemD support.
echo "downloading dependencies"
sudo pacman -Syy
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
echo "Packages and dependencies downloaded"
echo "Starting libvirtd..."
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
echo "Phase 1 finished!"
sudo awk '/^#.*unix_sock_group/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_ro_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_rw_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
username=$USER
sudo usermod -aG libvirt $username
echo "Phase 1 complete, restart your system for changes to take effect."

