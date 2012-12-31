##READ THIS##
this just installs the contents of the iso to a preformatted (fat16 or fat32) usb drive (or other flash media).

it does not check ...

it does not ask ...

it will burn you if you tell it the wrong thing and not tell you ...

***user beware!***

##usage##

```
(as root)
./dumb-installer.sh [/dev/sdX /path/to/iso/live.iso /path/of/build_dir]
./dumb-installer.sh ./dumb-installer.sh 
```

stick a "dumb-installer.conf" in the same directory and it will load the variables from that rather than get them from the command line. command line arguments will override config file values.

###config values###

The config file is a shell script with variables set in it. it is used via a dot include if it is found.

* dev - device path, without partition numbers (ie. /dev/sdb, /dev/mmcblk0)
* iso - path to iso (absolute)
* build_dir - directory to make directories and mount stuff in to transfer files and install syslinux

###Example###

```
#!/bin/sh
dev=/dev/sdb
iso=/home/guest/byzantium-v12.34-stable.iso
build_dir=/tmp
```
