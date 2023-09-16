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
# FAQ
Q. Why does this script exist?

A. Because I believe Virt Manager is the best front-end for QEMU, and has a lot more features than other front-ends (e.g. Gnome Boxes). The goal of this script is to make Virt Manager more accessible to people who either find its installation too daunting, or don't want to install and configure it manually.

Q. What do these error codes mean?

A. Error 1 means your distribution is not supported. If it's currently unsupported, It probably will be in the future, unless the packages aren't in your package manager's repos. Error 2 means your init system(the program that loads the OS and manages processes) is unsupported, if your init system is on the supported list, then it probably means I got the commands wrong. If that's the case, please report the error.

Q. Garuda Linux already configures Virt Manager out of the box, why don't you just use the code from that?

A. Shut up :`(

Q. Why is the code so horrible?

A. Yes I know I suck at shell scripting. And hey, if it's so crap, why don't you fix it yourself? Oh wait, you can with a commit!

# Things left to do
1. Automatically detect what init system the user is running, to add support for other init systems like OpenRC, Runit, etc.
2. Clean up the code and fix any bugs.
3. Add support for even more distros, like RedHat, OpenSuse, Nixos, Void, Gentoo, etc.
