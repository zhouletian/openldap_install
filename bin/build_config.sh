#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; cd ../; pwd)

. /etc/init.d/functions
TEMPLATE_PATH=$pragram_path/template
BASE_TEMPLATE_PATH=$TEMPLATE_PATH/base
HA_TEMPLATE_PATH=$TEMPLATE_PATH/HA
OUTPUT_PATH=$pragram_path/output
BASE_OUTPUT_PATH=$OUTPUT_PATH/base
HA_OUTPUT_PATH=$OUTPUT_PATH/HA

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $pragram_path/config/config.sh
fi

action "开始准备openldap基本配置..." /bin/true
passwd=`slappasswd -s ${LDAP_MANAGER_PASSWD}`
action "生成加密密码: $passwd..." /bin/true

cp $BASE_TEMPLATE_PATH/chrootpw.ldif.template $BASE_OUTPUT_PATH/chrootpw.ldif
cp $BASE_TEMPLATE_PATH/chdomain.ldif.template $BASE_OUTPUT_PATH/chdomain.ldif
cp $BASE_TEMPLATE_PATH/basedomain.ldif.template $BASE_OUTPUT_PATH/basedomain.ldif
action "模板拷贝完成" /bin/true


sed -i "s#\${salpdpasswd}#$passwd#g" $BASE_OUTPUT_PATH/chrootpw.ldif
action "生成chrootpw.ldif..." /bin/true

sed -i "s#\${salpdpasswd}#$passwd#g" $BASE_OUTPUT_PATH/chdomain.ldif
sed -i "s#\${dc}#$DC#g" $BASE_OUTPUT_PATH/chdomain.ldif
action "生成chdomain.ldif..." /bin/true

sed -i "s#\${dc}#$DC#g" $BASE_OUTPUT_PATH/basedomain.ldif
action "生成basedomain.ldif..." /bin/true


action "开始准备openldap高可用配置..." /bin/true
#高可用A B两个节点都执行
cp $HA_TEMPLATE_PATH/mod_syncprov.ldif.template $HA_OUTPUT_PATH/mod_syncprov.ldif
action "生成mod_syncprov.ldif..." /bin/true
cp $HA_TEMPLATE_PATH/syncprov.ldif.template $HA_OUTPUT_PATH/syncprov.ldif
action "生成syncprov.ldif..." /bin/true
#以下配置不同，需要读取config.sh
cp $HA_TEMPLATE_PATH/mod_ServerId.ldif.template $HA_OUTPUT_PATH/mod_ServerId.ldif
sed -i "s#\${server_id}#$SERVER_ID#g" $HA_OUTPUT_PATH/mod_ServerId.ldif
action "生成mod_ServerId.ldif..." /bin/true

cp $HA_TEMPLATE_PATH/master.ldif.template $HA_OUTPUT_PATH/master.ldif
cp $HA_TEMPLATE_PATH/masterMirrorMode.ldif.template $HA_OUTPUT_PATH/masterMirrorMode.ldif
action "生成masterMirrorMode.ldif..." /bin/true

sed -i "s#\${ldap_server_ip}#$OTHER_LDAP_SERVER_IP#g" $HA_OUTPUT_PATH/master.ldif
sed -i "s#\${dc}#$DC#g" $HA_OUTPUT_PATH/master.ldif
sed -i "s#\${manager_passwd}#$LDAP_MANAGER_PASSWD#g" $HA_OUTPUT_PATH/master.ldif
action "生成master.ldif..." /bin/true
action "openldap高可用配置生成完毕" /bin/true

