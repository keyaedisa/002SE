#!/usr/bin/bash

echo "welcome 2 002 Server Edition"
echo "with great power like this comes great responsibility.."
echo "ensure you never fall behind"
echo "learn all you can"
echo "and then apply"
echo "learn some more"
echo "and free yourself from digital tyranny"
echo
echo "begin!"
echo
kum="1"
echo "let us prepare the drive. but first.."
echo "you are warned these changes will be permanent. data WILL be lost. double sure you want to do this? (y/n)"
echo
while [ $kum != 0 ]; do
read YN
case $YN in
y | yes)
	kum="0"
	moreKum="1"
	echo
	echo "good. lets begin." && sleep 1.33
	echo
	while [ $moreKum != 0 ]; do
	echo "what drive should we prepare? (enter the drive u want exactly as you see it)"
	echo
	fdisk -l | grep -o '\/dev\S*\:' >> shitDriveList && cat shitDriveList | tr -d \: >> perfectDriveList && cat perfectDriveList
	echo
	read DRIVE
	echo $DRIVE >> desiredDrive
	cat perfectDriveList | grep -q -x --file=desiredDrive
		case $? in
		 0)
			moreKum=$?
			echo "sending new partition table" 
			echo -e '2048,616448,U\n,+,L\n' | sfdisk $DRIVE
			echo "done"
			echo "formatting partitions"
			mkfs.fat -F 32 ${DRIVE}1
			mkfs.xfs -f ${DRIVE}2
			echo "done"
			rm desiredDrive shitDriveList perfectDriveList
		 ;;
		 *)
			echo
			echo "that shit dont exist." && sleep 1.5
			cat perfectDriveList
			echo "but these ^^ do. dont fuck up."
			echo
			sleep 1.5
			rm desiredDrive shitDriveList perfectDriveList
		 ;;
		esac
	done
	;;
n | no)
	kum="0"
	echo
	echo "whatever.. bye."
	exit
	;;
*)
	echo
	echo "that didnt make sense. y(es) or n(o) plz"
	echo "you sure you want to install 002 Server Edition?"
	echo
	;;
esac
done
echo "preparing for install phase"
echo
kum="1"
echo "mounting root and efi"
mount ${DRIVE}2 /mnt
mount --mkdir ${DRIVE}1 /mnt/boot
echo "root and efi mounted to /mnt & /mnt/boot respectively"
echo 
echo "beginning core package install.. plz b patient"
echo
pacstrap /mnt base base-devel linux linux-firmware mkinitcpio systemd vim
pacstrap /mnt linux-headers
pacstrap /mnt broadcom-wl-dkms
pacstrap /mnt dialog efibootmgr git grub intel-ucode iw iwd man-db man-pages nano openssh polkit reflector texinfo xfsprogs
pacstrap /mnt xorg-server xorg-xfontsel xorg-xrandr xorg-xsetroot
pacstrap /mnt caddy nano-syntax-highlighting pipewire pipewire-pulse wireplumber xf86-video-intel
echo "done"
echo
echo "generating fstab"
echo
genfstab -U /mnt >> /mnt/etc/fstab
echo "done"
echo
echo "preparing 4 chroot"
echo
echo "preparing post install and chroot"
echo
cp -r /etc/systemd/network /mnt/
cp /etc/sudoers.d /mnt/
cp -r container /mnt/
cp /etc/nanorc /mnt/
cp chroot.bash /mnt/
chmod +x /mnt/chroot.bash
echo "begin chroot"
echo
sudo arch-chroot /mnt ./chroot.bash
echo
echo "all done! rebooting in 5 secs"
echo
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "brb!"
sleep 1
umount /mnt/boot
umount /mnt
#reboot
