#!/bin/bash
. function.sh
TMP1=`SCRIPTNAME`.log
> $TMP1
BAR
CODE [U-09] 패스워드 최소 사용기간 설정
cat << EOF >> $RESULT
[양호]: 패스워드 최소 사용기간이 1일(1주)로 설정되어 있는 경우
[취약]: 패스워드 최소 사용기간이 설정되어 있지 않는 경우
EOF
BAR

LOGINDEFSFILE=/etc/login.defs
SEARCHVALUE=PASS_MIN_DAYS
NUM=$(SearchValue VALUE $LOGINDEFSFILE $SEARCHVALUE)

if [ $NUM -ge 7 ] ; then
  OK "패스워드 최소 사용기간이 1일(1주)로 설정 되어 있습니다."
else
  WARN "패스워드 최소 사용기간이 1일(1주)로 설정 되어 있지 않습니다."
  INFO $TMP1 파일을 참고 하세요.
  echo "===================================================" >> $TMP1
  echo "1. $LOGINDEFSFILE 파일의 내용입니다." >> $TMP1
  echo "" >> $TMP1
  SearchValue KEYVALUE $LOGINDEFSFILE $SEARCHVALUE >> $TMP1
  echo "===================================================" >> $TMP1
fi
cat $RESULT
echo ; echo