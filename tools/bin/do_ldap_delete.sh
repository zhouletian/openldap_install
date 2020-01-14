#!/usr/bin/expect

ldap_manager=$1
ldap_user=$2
ldap_group=$3
ldap_manager_passwd=$4
dc=$5
ldapdelete -x -w ${ldap_manager_passwd} -D "${ldap_manager}" "uid=${ldap_user},ou=People,dc=$DC,dc=com"
ldapdelete -x -w ${ldap_manager_passwd} -D "${ldap_manager}" " cn=${ldap_group},ou=Group,dc=$DC,dc=com"


