#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)

. /etc/init.d/functions
action "开始安装openldap client..." /bin/true
yum -y install nss-pam-ldapd pam_ldap openldap-clients
action "安装openldap完毕..." /bin/true

$pragram_path/bin/build_client_config.sh
action "openldap client配置替换完毕..." /bin/true

sleep 3
systemctl start nslcd
action "启动openldap client..." /bin/true
systemctl enable nslcd
action "开启openldap client开机自启动..." /bin/true

