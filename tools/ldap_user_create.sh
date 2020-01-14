#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; pwd)
soft_path=$(cd "$(dirname "$0")"; cd ../; pwd)


USER_ID=$1
USER_NAME=$2
USER_PASSWD=$3
GROUP_ID=$4
GROUP_NAME=$5

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
        . ${OPENLDAP_CONF_DIR}/config.sh
else
        . $soft_path/config/config.sh
fi

#copy template
LDIF_FILE=$pragram_path/output/$USER_NAME.ldif
cat $pragram_path/template/ldap_user.template > $LDIF_FILE

#sed -i "s/\${group_name}/$GROUP_NAME/" $LDIF_FILE
sed -i "s/\${group_name}/$GROUP_NAME/g" $LDIF_FILE
sed -i "s/\${user_name}/$USER_NAME/g" $LDIF_FILE
sed -i "s/\${group_id}/$GROUP_ID/g" $LDIF_FILE
sed -i "s/\${user_id}/$USER_ID/g" $LDIF_FILE
sed -i "s/\${user_passwd}/$USER_PASSWD/g" $LDIF_FILE
sed -i "s/\${dc}/$DC/g" $LDIF_FILE

#////////expect//////////////////////
#EXPECT_TEMPLATE=$pragram_path/template/ldap_cmd_expect.template
#EXPECT_FILE=$pragram_path/output/do_ldap_cmd_expect_$USER_NAME.expect
DO_CREATE_SHELL=$pragram_path/bin/do_ldap_create.sh
LDAP_MANAGER="cn=Manager,dc=$DC,dc=com"

#cat $EXPECT_TEMPLATE > $EXPECT_FILE

#sed -i "s/\${ldap_manager}/$LDAP_MANAGER/g" $EXPECT_FILE
#sed -i "s#\${ldap_idif_path}#$LDIF_FILE#g" $EXPECT_FILE
#sed -i "s#\${ldap_manager_passwd}#$LDAP_MANAGER_PASSWD#g" $EXPECT_FILE


sh $DO_CREATE_SHELL $LDAP_MANAGER $LDAP_MANAGER_PASSWD $LDIF_FILE


