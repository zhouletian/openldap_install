#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)


. /etc/init.d/functions
action "开始安装openldap..." /bin/true
yum -y install openldap compat-openldap openldap-clients openldap-servers penldap-devel migrationtools 
action "安装openldap完毕..." /bin/true
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG
action "初始化openldap数据库配置..." /bin/true
systemctl start slapd
action "启动openldap..." /bin/true
systemctl enable slapd
action "开启openldap开机自启动..." /bin/true


$pragram_path/bin/build_config.sh

$pragram_path/bin/ldap_load.sh
action "加载openldap基本配置完毕..." /bin/true
systemctl restart slapd
action "重新启动openldap..." /bin/true
sleep 3
$pragram_path/bin/ldap_load_HA.sh
sleep 3
action "加载openldap高可用配置完毕..." /bin/true
systemctl restart slapd
action "重新启动openldap..." /bin/true
