#!/usr/bin/env bash
pragram_path=$(cd "$(dirname "$0")"; cd ../; pwd)

. /etc/init.d/functions
OUTPUT_PATH=$pragram_path/output
#BASE_OUTPUT_PATH=$OUTPUT_PATH/base
HA_OUTPUT_PATH=$OUTPUT_PATH/HA

ldapadd -Y EXTERNAL -H ldapi:/// -f $HA_OUTPUT_PATH/mod_syncprov.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f $HA_OUTPUT_PATH/syncprov.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f $HA_OUTPUT_PATH/mod_ServerId.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f $HA_OUTPUT_PATH/master.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f $HA_OUTPUT_PATH/masterMirrorMode.ldif

