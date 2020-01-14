## Openldap install 一键安装脚本
# 准备
## 适用系统
RHEL 7以上经过测试，其余平台咱不可用

## 软件源

如果能连接互联网，则忽略。

如果是内网环境，请提前搭建好yum源。目的是能够通过yum安装openldap。

即能执行以下命令：
```shell
yum -y install openldap compat-openldap openldap-clients openldap-servers penldap-devel migrationtools
yum -y install nss-pam-ldapd pam_ldap openldap-clients
```

# 配置
```shell

#以下是开启openldap高可用需要填的参数
#默认是开启ldap双主，此参数为另外一台ldap_server的IP
export OTHER_LDAP_SERVER_IP=172.16.150.171
#server的ID。两台ldap_server不能冲突
export SERVER_ID=0
#域组件名
export DC=hadoop
#管理员密码
export LDAP_MANAGER_PASSWD=123456

#客户端指定的ldap_server地址，可能是虚拟ip也可以是正常的ip
export LDAP_SERVER_IP=172.16.150.170
```
至此就可以开始安装了。

# LDAP Server

1、安装:
```shell
./install.sh
```
2、卸载:
```shell
./uninstall.sh
```
3、查看LDAP Server状态:(检查LDAP server服务)
```shell
./check.sh
```

# LDAP Client

1、安装:
```shell
./install_client.sh
```

2、卸载:
```shell
./uninstall_client.sh
```
