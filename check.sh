#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $pragram_path/config/config.sh
fi

ldapsearch -x -b "dc=$DC,dc=com" -H ldap://127.0.0.1
