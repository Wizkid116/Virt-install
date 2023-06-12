set -e
#Downloads KVM, QEMU, Virt-manager, and all its dependencies
echo "Downloading dependencies"
if command -v pacman >/dev/null; then #Arch
	sudo pacman -Syy
	sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
elif command -v apt-get >/dev/null; then #Debian/Ubuntu
	sudo apt-get update
	sudo apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
elif command -v dnf >/dev/null; then #Fedora
	sudo dnf update
	sudo dnf install -y qemu-kvm libvirt libvirt-client virt-install virt-manager
elif command -v yum >/dev/null; then #Red Hat/Cent OS
	sudo yum update
	sudo yum install -y qemu-kvm libvirt libvirt-client virt-install virt-manager
elif command -v emerge >/dev/null; then #Gentoo
	echo "WARNING: Untested Distro!"
	sudo emerge --sync
	sudo emerge app-emulation/qemu app-emulation/libvirt app-emulation/virt-manager net-misc/bridge-utils net-analyzer/openbsd-netcat app-emulation/libguestfs
elif command -v xbps-install >/dev/null; then #Void Linux
	echo "WARNING: Untested Distro!"
	sudo xbps-install -S
	sudo xbps-install qemu libvirt virt-manager bridge-utils dnsmasq netcat libguestfs
elif command -v nix-env >/dev/null; then #NixOS
	sudo nix-channel --update
	sudo nix-env -i qemu libvirt virt-manager bridge-utils dnsmasq netcat-openbsd libguestfs
else
	echo "Unsupported distro"
	exit 1
fi
#Checks if the user is running Artix Linux, then downloads extra
#dependencies based on the init system that is currently used
if [[ -f "/etc/artix-release" ]]; then #Artix
if command -v rc-status >/dev/null; then #OpenRC
	sudo pacman -S libvirt-openrc
elif command -v sv >/dev/null; then #Runit
	sudo pacman -S libvirt-runit
elif command -v dinitctl >/dev/null; then #Dinit
	sudo pacman -S libvirt-dinit
elif command -v s6-rc >/dev/null; then #s6
	sudo pacman -S libvirt-s6
else
	echo " "
fi
echo "Packages and dependencies downloaded"
# Starts the libvirtd service
echo "Starting libvirtd..."
if command -v systemctl >/dev/null; then # Systemd
	sudo systemctl start libvirtd
	sudo systemctl enable libvirtd
elif command -v rc-status >/dev/null; then #OpenRC
	sudo rc-update add libvirtd
	sudo rc-service libvirtd start
elif command -v sv >/dev/null; then #Runit
	sudo sv up libvirtd
	sudo ln -s /etc/sv/libvirtd /etc/runit/runsvdir/default/
elif command -v dinitctl >/dev/null; then #Dinit
	sudo dinitctl start libvirtd
	sudo dinitctl enable libvirtd
elif command -v s6-rc >/dev/null; then #s6
	sudo s6-rc -u change libvirtd
	sudo s6-rc-bundle-update add default libvirtd
elif command -v sysv-rc-conf >/dev/null; then #sysVinit
	sudo sysv-rc-conf libvirtd on
	sudo service libvirtd start
else
	echo "Unsupported init system"
	exit 2
fi
echo "Libvirtd started"
# Edits permissions in the libvirtd.conf file
echo "Editing config..."
sudo awk '/^#.*unix_sock_group/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_ro_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
sudo awk '/^#.*unix_sock_rw_perms/{sub(/^#/,"",$0)}1' /etc/libvirt/libvirtd.conf > temp && sudo mv temp /etc/libvirt/libvirtd.conf
# Adds current user to the libvirt group
sudo usermod -aG libvirt $USER
echo "Installation complete, restart your system for changes to take effect."
exit 0
