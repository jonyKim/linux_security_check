#!/bin/bash
. function.sh
BAR
CODE [U-66] SNMP 서비스 구동 점검
cat << EOF >> $RESULT
[양호]: SNMP 서비스를 사용하지 않는 경우
[취약]: SNMP 서비스를 사용하는 경우
EOF
BAR
ps -ef | grep snmp | grep -v grep >/dev/null 2>&1
if [ $? -eq 0 ] ; then
WARN SNMP 서비스를 사용하고 있습니다. 
# service snmpd stop
else
OK SNMP 서비스를 사용하지 않고 있습니다.
fi
echo >>$RESULT
echo >>$RESULT