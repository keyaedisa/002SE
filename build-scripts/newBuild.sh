#!/bin/bash

# Written by Keyaedisa
# Website in the works

source ../misc/bashFormatting

echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo "Step 1: Getting ready to build"
echo $fgMagenta
xUnicode 2730 49
echo $txReset

	[ -d ../misc ] || mkdir ../misc
	buildFolder=../misc/002SE-build
	outFolder=../misc/002SE-iso
	profile=../002SE
	
echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo "Step 2: Making sure you have latest archiso. Enter password if prompted"
echo $fgMagenta
xUnicode 2730 49
echo $txReset

	sleep 2
	sudo pacman -Su archiso --noconfirm

echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo "Step 3: All done. Getting ready to build the iso"
echo "Will be deleting previous work folder if one exists"
echo $fgMagenta
xUnicode 2730 49
echo $txReset

	if [[ -d $buildFolder ]]; then
		 sudo rm -rf $buildFolder
	fi

echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo "Step 3.5: Updating all references, including profiledef.sh"
echo $fgMagenta
xUnicode 2730 49
echo $txReset

	currentName=$(sed -n "s/(^iso_name=)//p" ../002SE/profiledef.sh | grep -o '[[:alnum:]]*')
	currentPublisher=$(sed -n 's/\(^iso_publisher=\)//p' ../002SE/profiledef.sh | sed 's/\([^"]*\)./\1/gi')

	echo "Current ISO name is $currentName. Want to rename?"
	read -n 3 YN
	case $YN in
		y | yes | Y | Yes )
			echo
			echo "Okay. What do you want to name this iso?"
			read newName
			echo "Okay. This ISO will now be named $newName"

 			echo "Changing all references in /etc/dev-rel/"
 			echo
 			sed -i 's/'$currentName'/'$newName'/gi' $buildFolder/archiso/airootfs/etc/dev-rel

			echo "Changing all references in profiledef.sh"
			sed -i 's/'$currentName'/'$newName'/gi' ../002SE/profiledef.sh
			;;
		n | no | N | No )
			echo
			echo "Okay. ISO name will remain $currentName"
			;;
		* )
			echo
			kum = 0
			if [$kum != 3]; do
			echo "Not a valid response. Try again"
			kum=$(($kum + 1))
			else
			echo "No way you've messed this up 3 times :/"
			kum=0
			fi
			;;
	esac
	echo
	echo "Current publisher is $currentPublisher. Want to change?"
	read -n 3 YN
	case $YN in
		y | yes | Y | Yes )
			echo
			echo "Okay. Who should be credited as publisher?"
			read newPublisher
			echo "Okay. This iso will now be named $newName"

			echo "Changing all references in profiledef.sh"
			sed -i 's/'$currentPublisher'/'$newPublisher'/gi' ../002SE/profiledef.sh
			;;
		n | no | N | No )
			echo
			echo "Okay. ISO Publisher will remain $currentPublisher"
			;;
		* )
			echo
			kum = 0
			if [$kum != 3]; do
			echo "Not a valid response. Try again"
			kum=$(($kum + 1))
			else
			echo "No way you've messed this up 3 times :/"
			kum=0
			fi
			;;
	esac
echo "Adding time to /etc/dev-rel"
dateBuild=$(date -d now)
echo "Iso build on : "$dateBuild
sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/" ../002SE/archiso/airootfs/etc/dev-rel

echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo
echo "Step 4: Time to build ISO. This will take a while. Go grab a drink or something"
echo $fgMagenta
xUnicode 2730 49
echo $txReset

sudo mkarchiso -v -w $buildFolder -o $outFolder $profile

echo $fgMagenta
xUnicode 2730 49
echo $txReset
echo
echo "DONE! Look in misc/ for your build and iso folder"
echo $fgMagenta
xUnicode 2730 49
echo $txReset
