#!/bin/bash

MAINTAINER='Ali Riza Keles, alirza@zetaops.io'
export DEBIAN_FRONTEND='noninteractive'

# set hostname ip adress
IP_ADDRESS=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
echo "$IP_ADDRESS     $(hostname)" >> /etc/hosts

# if strong consistency and riak control are unset, set them to defaults
: ${STRONG_CONSISTENCY:='on'}
: ${RIAK_CONTROL:='off'}

# add riak repo
# https://packagecloud.io/install/repositories/basho/riak/config_file.list?os=ubuntu&dist=trusty
curl https://packagecloud.io/gpg.key | sudo apt-key add -
echo -e 'deb https://packagecloud.io/basho/riak/ubuntu/ trusty main \ndeb-src https://packagecloud.io/basho/riak/ubuntu/ trusty main' >  /etc/apt/sources.list.d/basho.list

# install basic packages
sudo apt-get install -y libpam0g-dev apt-transport-https wget

# file limits and some recommended tunings
echo 'ulimit -n 65536' >> /etc/default/riak
echo "session    required   pam_limits.so" >> /etc/pam.d/common-session
echo "session    required   pam_limits.so" >> /etc/pam.d/common-session-noninteractive
sed '$i\*              soft     nofile          65536\n\*              hard     nofile          65536'  /etc/security/limits.conf

echo 1024 > /sys/block/vdb/queue/nr_requests
echo 'ethtool -K eth0 tso off' >> /etc/rc.local

# sysctl tunings
echo '# riak tunings..' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_max_syn_backlog=40000' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_sack=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_window_scaling=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_fin_timeout=15' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_keepalive_intvl=30' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_tw_reuse=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_moderate_rcvbuf=1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_mem  = 134217728 134217728 134217728' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_rmem = 4096 277750 134217728' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_wmem = 4096 277750 134217728' >> /etc/sysctl.conf
echo 'net.core.netdev_max_backlog = 300000' >> /etc/sysctl.conf
echo 'net.core.wmem_default = 8388608' >> /etc/sysctl.conf
echo 'net.core.rmem_default = 8388608' >> /etc/sysctl.conf
echo 'net.core.rmem_max = 134217728' >> /etc/sysctl.conf
echo 'net.core.wmem_max = 134217728' >> /etc/sysctl.conf
echo 'net.core.somaxconn=40000' >> /etc/sysctl.conf
echo 'vm.swappiness=0' >> /etc/sysctl.conf
echo 'vm.dirty_background_ratio = 0' >> /etc/sysctl.conf
echo 'vm.dirty_background_bytes = 209715200' >> /etc/sysctl.conf
echo 'vm.dirty_ratio = 40' >> /etc/sysctl.conf
echo 'vm.dirty_bytes = 0' >> /etc/sysctl.conf
echo 'vm.dirty_writeback_centisecs = 100' >> /etc/sysctl.conf
echo 'vm.dirty_expire_centisecs = 200' >> /etc/sysctl.conf

# update linux kernel options and update grub
sed 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="elevator=noop /' /etc/default/grub
sed 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="clocksource=hpet /' /etc/default/grub
update-grub


# Install Java 8
apt-get update -qq && apt-get install -y software-properties-common && \
    apt-add-repository ppa:webupd8team/java -y && apt-get update -qq && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer

# install riak
apt-get install -y riak

# stop riak service
service riak stop

# replace ip address nodename
sed -i "s/riak@127.0.0.1/riak@${IP_ADDRESS}/" /etc/riak/riak.conf

# set strong consistency and riak_control on or off depends on docker run env vars
sed -i "s/strong_consistency = off/strong_consistency = ${STRONG_CONSISTENCY}/" /etc/riak/riak.conf
sed -i "s/riak_control = off/riak_control = ${RIAK_CONTROL}/" /etc/riak/riak.conf

# Get riak.conf from zetaops public cloud tools
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/conf/riak.conf -O /etc/riak/riak.conf
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/conf/advanced.config -O /etc/riak/advanced.config
chown riak:riak /etc/riak/riak.conf && chmod 755 /etc/riak/riak.conf

# Get Certificate Files
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/cacertfile.pem -O /etc/riak/cacertfile.pem
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/cert.pem -O /etc/riak/cert.pem
wget https://raw.githubusercontent.com/zetaops/zcloud/master/containers/riak/certs/key.pem -O /etc/riak/key.pem
chown riak:riak /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem
chmod 600 /etc/riak/cacertfile.pem /etc/riak/cert.pem /etc/riak/key.pem


# sleep 10
# apt-get install -y dnsutils

# declare -a nodes=( 1 2 3 4 5 )
# for i in ${nodes[@]}; do
#    IP=$(dig +short zx-ubuntu-riak-0$i.c.zetaops-academic-erp.internal | awk '{ print ; exit }');
#    PONG=$(curl -s http://$IP:8098/ping)
#    if [ -n "$PONG" ] && [ "$PONG" == "OK" ] && [ "$IP" != "$IP_ADDRESS"]; then
#      RESULT=$(riak-admin cluster join riak@$IP)
#      if [ "$RESULT" == *"Success"* ]; then
#          break;
#      fi
#    fi
# done

# create 5 node riak instance based on ubuntu and join cluster on gce platform
# for ((i=1; i<6; i++)) do gcloud -q compute instances create  \
# --zone europe-west1-d --image=ubuntu-14-04 --machine-type "n1-standard-2" \
# --can-ip-forward zx-ubuntu-riak-0$i \
# --metadata-from-file startup-script=ubuntu_riak.sh; done
