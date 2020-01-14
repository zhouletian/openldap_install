#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; cd ../; pwd)

. /etc/init.d/functions
OUTPUT_PATH=$pragram_path/output
TEMPLATE_PATH=$pragram_path/template
CLIENT_OUTPUT_PATH=$OUTPUT_PATH/client
CLIENT_TEMPLATE_PATH=$TEMPLATE_PATH/client

#配置
if [[ -f ${OPENLDAP_CONF_DIR}/config.sh ]]; then
	. ${OPENLDAP_CONF_DIR}/config.sh
else
	. $pragram_path/config/config.sh
fi

C_FILE_1=/etc/sysconfig/authconfig
C_FILE_2=/etc/pam.d/system-auth
C_FILE_3=/etc/openldap/ldap.conf
C_FILE_4=/etc/nsswitch.conf
C_FILE_5=/etc/nslcd.conf
C_FILE_6=/etc/pam_ldap.conf

#sed -i '/^USEMKHOMEDIR=/cUSEMKHOMEDIR=yes' $C_FILE_1
#sed -i '/^PASSWDALGORITHM=/cPASSWDALGORITHM=yes' $C_FILE_1
#sed -i '/^USELDAPAUTH=/cUSELDAPAUTH=yes' $C_FILE_1
#sed -i '/^USELDAP=/cUSELDAP=yes' $C_FILE_1
#sed -i '/^USESYSNETAUTH=/cUSESYSNETAUTH=yes' $C_FILE_1

cp $CLIENT_TEMPLATE_PATH/authconfig.template $CLIENT_OUTPUT_PATH/authconfig
cp $CLIENT_TEMPLATE_PATH/system-auth.template $CLIENT_OUTPUT_PATH/system-auth
cp $CLIENT_TEMPLATE_PATH/ldap.conf.template $CLIENT_OUTPUT_PATH/ldap.conf
cp $CLIENT_TEMPLATE_PATH/nsswitch.conf.template $CLIENT_OUTPUT_PATH/nsswitch.conf
cp $CLIENT_TEMPLATE_PATH/nslcd.conf.template $CLIENT_OUTPUT_PATH/nslcd.conf
cp $CLIENT_TEMPLATE_PATH/pam_ldap.conf.template $CLIENT_OUTPUT_PATH/pam_ldap.conf

sed -i "s#\${ldap_server_ip}#$LDAP_SERVER_IP#g" $CLIENT_OUTPUT_PATH/ldap.conf
sed -i "s#\${ldap_server_ip}#$LDAP_SERVER_IP#g" $CLIENT_OUTPUT_PATH/nslcd.conf
sed -i "s#\${ldap_server_ip}#$LDAP_SERVER_IP#g" $CLIENT_OUTPUT_PATH/pam_ldap.conf



cp $CLIENT_OUTPUT_PATH/authconfig $C_FILE_1
cp $CLIENT_OUTPUT_PATH/system-auth $C_FILE_2
cp $CLIENT_OUTPUT_PATH/ldap.conf $C_FILE_3
cp $CLIENT_OUTPUT_PATH/nsswitch.conf $C_FILE_4
cp $CLIENT_OUTPUT_PATH/nslcd.conf $C_FILE_5
cp $CLIENT_OUTPUT_PATH/pam_ldap.conf $C_FILE_6



