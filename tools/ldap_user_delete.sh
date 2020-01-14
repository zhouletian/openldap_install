#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)
soft_path=$(cd "$(dirname "$0")"; cd ../; pwd)


USER_NAME=$1
GROUP_NAME=$2

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $soft_path/config/config.sh
fi

#LDAP_DELETE_EXPECT_TEMPLATE=$pragram_path/template/ldap_delete_expect.template
#LDAP_DELETE_EXPECT_FILE=$pragram_path/output/do_ldap_delete_expect_$USER_NAME.expect
DO_LDAP_DELETE_SHELL=$pragram_path/bin/do_ldap_delete.sh
LDAP_MANAGER="cn=Manager,dc=$DC,dc=com"
LDAP_MANAGER_PASSWD=yoyosys

#cat $LDAP_DELETE_EXPECT_TEMPLATE > $LDAP_DELETE_EXPECT_FILE

#sed -i "s/\${ldap_user}/$USER_NAME/g" $LDAP_DELETE_EXPECT_FILE
#sed -i "s#\${ldap_group}#$GROUP_NAME#g" $LDAP_DELETE_EXPECT_FILE
#sed -i "s#\${ldap_manager}#$LDAP_MANAGER#g" $LDAP_DELETE_EXPECT_FILE
#sed -i "s#\${ldap_manager_passwd}#$LDAP_MANAGER_PASSWD#g" $LDAP_DELETE_EXPECT_FILE

sh $DO_LDAP_DELETE_SHELL $LDAP_MANAGER $USER_NAME $GROUP_NAME $LDAP_MANAGER_PASSWD
