#!/bin/bash

if [ -f ./dumb-installer.conf ] ;then
	echo config file found
	. ./dumb-installer.conf
fi

if ! [ -z ${1} ] ;then
	dev=$1
fi
if ! [ -z ${2} ] ;then
	iso=$2
fi
if ! [ -z ${3} ] ;then
	build_dir=/tmp
fi

check_args(){
	case $dev in
		/dev/[sh]d[a-z][0-9]*)
			# rip digits off
			dev=${dev//[0-9]*/}
			;;
		/dev/mmcblk[0-9][p0-9]*)
			# rip off p and following digits
			dev=${dev//p*/}
			;;
		*)
			echo -n
			;;
	esac
	if ! [ -e $dev ] || [ "$dev" == "" ] ;then
		echo "device '$dev' does not exists"
		usage
		exit 1
	fi
	if ! [ -f $iso ] || [ "$iso" == "" ] ;then
		echo "iso file '$iso' does not exists"
		usage
		exit 1
	fi
	if ! [ -d $build_dir ] || [ "$build_dir" == "" ] ;then
		echo "build directory '$build_dir' does not exists"
		usage
		exit 1
	fi
}

usage() {
	echo "prereqs: syslinux, rsync, mount.vfat, mount.loop, usb drive formatted with fat16 or fat32"
	echo "${0} /dev/sdX /path/to/porteus.iso"
}

setup_build_env(){
	mkdir -p $build_dir/{iso,usb}
	mount -o loop $iso $build_dir/iso
	mount -t vfat ${dev}1 $build_dir/usb
}

install_files() {
	rsync -avr $build_dir/iso/* $build_dir/usb/
}

install_syslinux(){
	cwd=`pwd`
	cd $build_dir/usb/
	syslinux -i -d boot/syslinux $dev
	cd $cwd
}

check_args

setup_build_env
install_files
install_syslinux

