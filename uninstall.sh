#!/usr/bin/env bash
. /etc/init.d/functions
action "准备停止openldap..." /bin/true
systemctl stop slapd
action "停止openldap..." /bin/true
yum -y remove compat-openldap openldap-clients openldap-servers
action "卸载openldap..." /bin/true
rm -rf /var/lib/ldap/*
rm -rf /etc/openldap/slapd.d/*
action "删除openldap，数据目录..." /bin/true

