#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)

USER_NAME=$1
NEW_PASSWD=$2

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $soft_path/config/config.sh
fi

DO_LDAP_MODIFY_PASSWD_SHELL=$pragram_path/bin/do_ldap_modify_passwd.sh
LDAP_MANAGER="cn=Manager,dc=$DC,dc=com"

sh $DO_LDAP_MODIFY_PASSWD_SHELL $LDAP_MANAGER $USER_NAME $LDAP_MANAGER_PASSWD $NEW_PASSWD $DC
