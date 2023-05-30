# Virt-Install
This is a very simple shell script used to automatically install and configure KVM/QEMU & Virt-Manager on most Arch, Debian, and Fedora based distros.
# Installation
```bash
git clone https://github.com/Wizkid116/Virt-install.git
cd Virt-install
./virt-install.sh
#Run the below command if it fails to run
sudo chmod +x virt-install.sh
```
# Things left to do
1. Automatically detect what init system the user is running, to add support for other init systems like OpenRC, Runit, etc.
2. Clean up the code and fix any bugs.
3. Add support for even more distros, like RedHat, OpenSuse, Nixos, Void, Gentoo, etc.
