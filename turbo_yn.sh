#!/bin/bash

# Tested on Ubuntu, requires msr-tools package to be installed.
# Amazon Linux needs http://rpmfind.net/linux/rpm2html/search.php?query=msr-tools%28x86-64%29


CPUS=$(cat /proc/cpuinfo | grep "^processor" | awk -F: {'print $2'})

sudo modprobe msr

echo "Checking to see if Intel Turbo Boost is enabled on CPUs"

for CPU in $CPUS
  do
    TURBO=$(sudo rdmsr -p$CPU 0x1a0 -f 38:38)
    if [ $TURBO = 0 ]
      then
        YN="Enabled"
      else
        YN="Disabled"
     fi

    echo "CPU: " $CPU "Value: " $TURBO "Status: " $YN
  done

