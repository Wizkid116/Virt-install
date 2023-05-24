set -e
#Downloads all KVM, QEMU, Virt-manager, and all its dependencies
echo "downloading dependencies"
#This whole bit of code is new and semi-tested :]
if command -v apt-get >/dev/null; then
	sudo apt-get update
	sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
elif command -v pacman >/dev/null; then
	sudo pacman -Syy
	sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
elif command -v dnf >/dev/null; then
	sudo dnf update
	sudo dnf install -y qemu-kvm libvirt libvirt-client virt-install virt-manager
else
	echo "Unsupported distro"
	exit 1
fi

echo "Packages and dependencies downloaded"
# Starts the libvirtd service
echo "Starting libvirtd..."
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
echo "Libvirtd started"
# Edits some permissions in the libvirtd.conf file
echo "Editing config..."
sudo awk '/^#.*unix_sock_group/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_ro_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_rw_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
# Adds current user to the libvirt group
sudo usermod -aG libvirt $USER
echo "Installation complete, restart your system for changes to take effect."
exit 0
