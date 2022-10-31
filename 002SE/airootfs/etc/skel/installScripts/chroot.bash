#!/usr/bin/bash

echo "succesful chroot"
echo
echo "updating time zone and synchronizing system clock"
echo
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
#timedatectl set-timezone America/New_York
echo "generating locales"
echo
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo
echo "done"
echo
echo "updating hostname"
echo
echo "newKai" >> /etc/hostname
echo
echo "setting up networkd"
echo
mv network /etc/systemd/
echo "done"
echo
echo "setting up sudoers"
echo
mv sudoers.d /etc/
echo "enter username:"
read NEWUSR
useradd -m -G wheel $NEWUSR
echo "enter password:"
passwd $NEWUSR
#echo "recreating initramfs.. plz b patient"
#echo
#mkinitcpio -P
echo "done"
echo
echo "enabling core functions"
echo
systemctl enable systemd-networkd systemd-resolved polkit iwd
mv nanorc /etc/
#echo "installing yay"
#echo
#mv container /home/$NEWUSR/
#cd /home/$NEWUSR
#sudo -u $NEWUSR git clone https://aur.archlinux.org/yay.git
#cd yay
#sudo -u $NEWUSR makepkg -si --noconfirm
#cd ..
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
rm -rf container
echo "installing grub to /boot"
echo
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
echo "done"
echo
echo "creating grub config"
echo
grub-mkconfig -o /boot/grub/grub.cfg
echo "done"
echo
echo "exiting chroot"
echo
exit
