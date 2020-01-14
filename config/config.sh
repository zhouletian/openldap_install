#以下是开启openldap高可用需要填的参数
#默认是开启ldap双主，此参数为另外一台ldap_server的IP
export OTHER_LDAP_SERVER_IP=172.16.150.171
#server的ID。两台ldap_server不能冲突
export SERVER_ID=0
#域组件名
export DC=cebbank
#管理员密码
export LDAP_MANAGER_PASSWD=123456

#客户端指定的ldap_server地址，可能是虚拟ip也可以是正常的ip
export LDAP_SERVER_IP=172.16.150.170

