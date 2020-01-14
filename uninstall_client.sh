#!/usr/bin/env bash
. /etc/init.d/functions
action "准备停止openldap client..." /bin/true
systemctl stop nslcd
action "停止openldap client..." /bin/true
yum -y remove nss-pam-ldapd pam_ldap openldap-clients

