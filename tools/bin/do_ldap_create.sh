#!/usr/bin/env bash

ldap_manager=$1
ldap_manager_passwd=$2
ldap_idif_path=$3
ldapadd -x -w ${ldap_manager_passwd} -D "${ldap_manager}" -f "${ldap_idif_path}" 
