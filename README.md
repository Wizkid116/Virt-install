# Virt-Install - TESTING
This is the testing branch for the Virt-install script.
# Installation
```bash
git clone --branch Testing https://github.com/Wizkid116/Virt-install.git #Downloads the script
cd Virt-install #Change directory the terminal is in into the Virt-install directory
sudo chmod +x virt-install.sh #Makes the script executable
./virt-install.sh #Run the script
```
# Things left to do
1. Automatically detect what init system the user is running, to add support for other init systems like OpenRC, Runit, etc.
2. Clean up the code and fix any bugs.
3. Add support for even more distros, like RedHat, OpenSuse, Nixos, Void, Gentoo, etc.
