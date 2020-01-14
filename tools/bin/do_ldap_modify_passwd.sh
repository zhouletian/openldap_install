#!/usr/bin/expect

ldap_manager=$1
ldap_user=$2
ldap_manager_passwd=$3
ldap_new_passwd=$4
dc=$5
ldappasswd -x -D "${ldap_manager}" -w ${ldap_manager_passwd} -s ${ldap_new_passwd} "uid=${ldap_user},ou=People,dc=$dc,dc=com"


