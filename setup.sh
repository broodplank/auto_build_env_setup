#!/bin/sh

clear
echo "----------------------------------------"
echo "- Automated Build Environment Setup    -"
echo "- version: 1.0                         -"
echo "-                                      -"
echo "- by broodplank1337 @ XDA              -"
echo "- www.broodplank.net                   -" 
echo "----------------------------------------"
echo " "
echo " "
busybox sleep 2
echo "---> Requesting root password for later use"
echo "Note: If you don't know the root password press control + c"
echo "      then enter 'sudo passwd root' to choose a root password"
echo " "
sudo echo "Root access granted"

busybox sleep 1
clear

echo " "
echo "---> Installing Java..."
echo " "
busybox sleep 1
cp jdk-6u32-linux-x64.bin ~/jdk-6u32-linux-x64.bin
chmod +x ~/jdk-6u32-linux-x64.bin
cd ~/
./jdk-6u32-linux-x64.bin
sudo mv jdk1.6.0_32 /usr/lib/jvm/
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.6.0_32/bin/javac 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.6.0_32/bin/java 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/lib/jvm/jdk1.6.0_32/bin/javaws 1
sudo update-alternatives --config javac
sudo update-alternatives --config java
sudo update-alternatives --config javaws
ls -la /etc/alternatives/java*
clear

echo " "
echo "---> Getting required packages..."
echo " "
busybox sleep 1
sudo apt-get update
sudo apt-get install git-core gnupg flex bison gperf build-essential zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 libgl1-mesa-dev g++-multilib mingw32 openjdk-6-jdk tofrodos python-markdown libxml2-utils xsltproc zlib1g-dev:i386 git dos2unix
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so
sudo apt-get install linux-libc6-dev:i386
sudo apt-get -f install
sudo apt-get install pngcrush
clear

echo " "
echo "---> Installing Repo..."
echo " "
busybox sleep 1
mkdir ~/bin
PATH=~/bin:$PATH
curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > ~/bin/repo
chmod a+x ~/bin/repo
clear

echo " "
echo "---> Cloning Prebuilt Repository (compiler)"
echo "Repo Size: 1.3gb"
echo "This may take a while... depending on your internet speed"
echo " "
busybox sleep 2
cd ~/
git clone https://android.googlesource.com/platform/prebuilt
clear

echo " "
echo "---> Extracting I9001 Kernel Source"
echo "Kernel Source Size: 440mb"
echo " "
busybox sleep 2
cd ~/
mkdir -p ~/i9001_kernel
cd ~/envsetup
cp GT-I9001_Kernel.tar.gz ~/i9001_kernel/GT-I9001_Kernel.tar.gz
cd ~/i9001_kernel
tar xvfz GT-I9001_Kernel.tar.gz
cd ~/i9001_kernel/kernel/arch/arm/configs
echo " "
echo "---> Copying ARIESVE_DEFCONFIG to source root"
echo " "
busybox sleep 1
cp ariesve_rev00_defconfig ~/i9001_kernel/kernel/.config
clear

echo " "
echo "---> Environment setup done!"
echo " "
busybox sleep 1
echo "Paths:"
echo "- i9001 kernel source: ~/i9001_kernel/kernel/"
echo "- Compiler path: ~/prebuilt/"
echo " "
busybox sleep 1
echo "Start xconfig for the kernel source?"
echo " "
echo "Please make your choice:"
ShowMenu () {
	echo "1) yes (start xconfig)"
	echo "2) no (exit script)"
}

while [ 1 ]
do
		ShowMenu
		read CHOICE
	case "$CHOICE" in
		"1")
		echo " "
		echo "Running Xconfig"
		echo " "
		busybox sleep 1
		cd ~/i9001_kernel/kernel/
		export ARCH=arm
		export CROSS_COMPILE=arm-eabi-
		export PATH=$PATH:~/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/
		make xconfig
		clear
		echo " "
		echo "Be sure to check the Patches & Addons folder! It contains:"
		echo " "
		echo "- Update for kernel source, HKTW Patch and Localversion hack"
		echo "- Fast xconfig script (./xconfig)"
		echo "- Fast compile script (./compile)"
		busybox sleep 10
		exit
		exit
		;;
	"2")
		echo "Exiting..."
		busybox sleep 1
		clear
		echo " "
		echo "Be sure to check the Patches & Addons folder! It contains:"
		echo " "
		echo "- Update for kernel source, HKTW Patch and Localversion hack"
		echo "- Fast xconfig script (./xconfig)"
		echo "- Fast compile script (./compile)"
		busybox sleep 10
		exit
		exit
		;;
	esac
done
