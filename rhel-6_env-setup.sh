#!/bin/bash

# Download RPMforge

# By Matt Williams

 

# Get your packages:

 

wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

 

# Install DAG's GPG key

 

rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt

 

if [ $? != 0 ]

then

    echo "Key has already been imported!"

fi

 

# Verify the package you have downloaded

rpm -k rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

 

# Install the package

 

rpm -ivh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm

 

# Download a package to see if it works

 

yum install htop

 

# Update yum.conf for install of yum-priorities

if [ $(grep -e 'plugins=1' /etc/yum.conf) -ge 1 ]

then

    break

else

    echo "plugins=1" >> /etc/yum.conf

fi

 

# Install yum-priorities

yum install yum-plugin-priorities

 

_yum_test='/etc/yum/pluginconf.d/priorities.conf'

 

if [ -f $_yum_test ]

then

    echo "$_yum_test is already here!"

else

    touch /etc/yum/pluginconf.d/priorities.conf

fi

echo '[main]' >> /etc/yum/pluginconf.d/priorities.conf

echo 'enabled=1' >> /etc/yum/pluginconf.d/priorities.conf

 

# Install the Extra Packages for Enterprise Linux (EPEL) Next!
#This might have to be updated

wget http://mirrors.nebo.edu/public/epel/6/i386/epel-release-6-8.noarch.rpm

rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6

rpm -k epel-release-6-8.noarch.rpm

rpm -ivh epel-release-6-8.noarch.rpm

 

# Install fuse-ntfs-3g

 

_dkms_checker=$(rpm -qa dkms*)

if [ $_dkms_checker -ge 1 ]

then

    yum remove dkms-fuse
fi

 

yum --enablerepo=rpmforge install fuse fuse-ntfs-3g

yum install ntfsprogs ntfsprogs-gnomevfs
