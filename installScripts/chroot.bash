#!/usr/bin/bash

echo "succesful chroot"
echo
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/keyaedisa/Valuca.git ${ZSH_CUSTOM}/themes/Valuca
cp container/.zshrc ~/
source ~/.zshrc
echo "updating time zone and synchronizing system clock"
echo
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc --utc
echo "KEYMAP=us" >> /etc/vconsole.conf
#timedatectl set-timezone America/New_York
echo "generating locales"
echo
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo
echo "done"
echo
echo "updating hostname"
echo
echo "ValenSE" >> /etc/hostname
echo
echo "setting up networkd"
echo
#mv network /etc/systemd/
echo "done"
echo
echo "setting up sudoers"
echo
#mv sudoers /etc/sudoers
echo "enter username:"
read NEWUSR
useradd -m -G wheel,storage,power,log -s /bin/zsh $NEWUSR
echo "enter password:"
passwd $NEWUSR
echo "recreating initramfs.. plz b patient"
echo
mkinitcpio -P linux
echo "done"
echo
echo "enabling core functions"
echo
systemctl enable sshd systemd-networkd systemd-resolved polkit iwd
#mv nanorc /etc/
#echo "installing grub again to be sure"
#pacman -Sy
#pacman -S grub
pacman -S refind
refind-install
echo
cp -rf container /home/$NEWUSR/
cd /home/$NEWUSR
mkdir .config
mkdir .config/nano
cp /etc/nanorc .config/nano/
cp -rf container/nanorc.nanorc /usr/share/nano-syntax-highlighting/
echo "installing yay"
sudo -u $NEWUSR git clone https://aur.archlinux.org/yay-bin.git && sleep 2.0
cd yay/
sudo -u $NEWUSR makepkg -si --noconfirm
cd ..
rm -rf /home/$NEWUSR/container
#echo "installing dwm, dmenu, ly, and st"
#echo
#sudo -u $NEWUSR yay -S --noconfirm ly
#systemctl enable ly
#sudo -u $NEWUSR git clone https://git.suckless.org/dwm
#cp container/dwm/config.def.h dwm/config.h
#cp container/dwm/config/def.h dwm/config.def.h
#mkdir /usr/share/xsessions
#mv container/dwm.desktop /usr/share/xsessions/
#mv container/startdwm /usr/local/bin/
#chmod +x /usr/local/bin/startdwm
#mkdir /home/$NEWUSR/logs
#cd dwm
#make install
#cd ..
#sudo -u $NEWUSR git clone https://git.suckless.org/dmenu
#cd dmenu
#make install
#cd ..
#sudo -u $NEWUSR git clone https://git.suckless.org/st
#cp container/st/config.def.h st/config.h
#cp container/st/config.def.h st/config.def.h
#cd st
#make install
#cd ..
#this is ugly patch 4 now, will rewrite this not so shit in the future maybe
#mkdir /etc/scripts/
#mkdir /etc/scripts/keyboard
#cp container/kbBacklightManager.sh /etc/scripts/keyboard/
#cp -r container/dwmblocks/ ./
#cd dwmblocks
#make install
#cd ..
#end of ugly patch
#rm -rf container
echo "installing and setting up syslinux"
echo
syslinux-install_update -i -a -m
cd /
cp -r container/syslinux /boot/
mkinitcpio -P linux
rm -rf container
echo "done"
echo
#echo "creating grub config"
#echo
#grub-mkconfig -o /boot/grub/grub.cfg
#echo "done"
#echo
echo "exiting chroot"
echo
exit
