#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; cd ../; pwd)

. /etc/init.d/functions
OUTPUT_PATH=$pragram_path/output
BASE_OUTPUT_PATH=$OUTPUT_PATH/base
#HA_OUTPUT_PATH=$OUTPUT_PATH/HA

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $pragram_path/config/config.sh
fi


ldapadd -Y EXTERNAL -H ldapi:/// -f $BASE_OUTPUT_PATH/chrootpw.ldif
#导入基本Schema模式
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

ldapadd -Y EXTERNAL -H ldapi:/// -f $BASE_OUTPUT_PATH/chdomain.ldif
ldapadd -x -D cn=Manager,dc=$DC,dc=com -w ${LDAP_MANAGER_PASSWD} -f $BASE_OUTPUT_PATH/basedomain.ldif

