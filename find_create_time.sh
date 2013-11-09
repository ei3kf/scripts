#!/bin/bash

# Find create time of a file on an EXT4 file-system

F=$1

if [ ! -f $F ]
  then
    echo ""
    echo "File does not exist."
    echo ""
    exit 1
fi

I=$(ls -i $F | awk '{print $1}')
D=$(df $F | awk '{print $1}' | grep "^/dev/")
FS=$(mount | grep $D | awk '{print $5}')

if [ $FS != "ext4" ]
  then
    echo ""
    echo "Only works on ext4 - sorry"
    echo ""
    exit 1
fi

CRT=$(debugfs -R "stat <${I}>" ${D} | awk -F "crtime:" '{print $2}' | awk -F "--" '{print $2}')

echo "File    : " ${F}
echo "Inode   : " ${I}
echo "Disk    : " ${D}
echo "FS      : " ${FS}
echo "Created : " ${CRT}

exit 0

