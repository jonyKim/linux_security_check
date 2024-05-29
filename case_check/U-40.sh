. function.sh
MAIN1
LIST3
BAR
CODE [U-40] DoS 공격에 취약한 서비스 비활성화
LEVEL 상
cat << EOF >> $RESULT
[ 양호 ] : DoS 공격에 취약한 echo, discard, daytime, chargen 서비스가 비활성화 된 경우
[ 취약 ] : DoS 공격에 취약한 echo, discard, daytime, chargen 서비스 활성화 된 경우
EOF
BAR
PRINT1
ls /etc/xinetd.d/echo* >/dev/null 2>&1
if [ $? -ne 0 ] ; then
OK /etc/xinetd.d/echo 파일이 존재하지 않습니다.
else
for i in `ls /etc/xinetd.d/echo*`
do
WARN $i 파일이 존재합니다.
if [ `cat $i | grep disable | awk '{print $3}'` = yes ] ; then
OK $i 파일에 대한 서비스가 비활성화 되어 있습니다.
else
WARN $i 파일에 대한 서비스가 활성화 되어 있습니다.
fi
done
fi
LINE
ls /etc/xinetd.d/discard* >/dev/null 2>&1
if [ $? -ne 0 ] ; then
OK /etc/xinetd.d/echo 파일이 존재하지 않습니다.
else
for i in `ls /etc/xinetd.d/discard*`
do
WARN $i 파일이 존재합니다.
if [ `cat $i | grep disable | awk '{print $3}'` = yes ] ; then
OK $i 파일에 대한 서비스가 비활성화 되어 있습니다.
else
WARN $i 파일에 대한 서비스가 활성화 되어 있습니다.
fi
done
fi
LINE
ls /etc/xinetd.d/daytime* >/dev/null 2>&1
if [ $? -ne 0 ] ; then
OK /etc/xinetd.d/echo 파일이 존재하지 않습니다.
else
for i in `ls /etc/xinetd.d/daytime*`
do
WARN $i 파일이 존재합니다.
if [ `cat $i | grep disable | awk '{print $3}'` = yes ] ; then
OK $i 파일에 대한 서비스가 비활성화 되어 있습니다.
else
WARN $i 파일에 대한 서비스가 활성화 되어 있습니다.
fi
done
fi
LINE
ls /etc/xinetd.d/chargen* >/dev/null 2>&1
if [ $? -ne 0 ] ; then
OK /etc/xinetd.d/echo 파일이 존재하지 않습니다.
else
for i in `ls /etc/xinetd.d/chargen*`
do
WARN $i 파일이 존재합니다.
if [ `cat $i | grep disable | awk '{print $3}'` = yes ] ; then
OK $i 파일에 대한 서비스가 비활성화 되어 있습니다.
else
WARN $i 파일에 대한 서비스가 활성화 되어 있습니다.
fi
done
fi

cat $RESULT
echo; echo