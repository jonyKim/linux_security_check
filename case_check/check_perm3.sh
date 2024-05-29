#!/bin/bash
. /root/scripts/functions.sh
# 1) 변수 설정 및 초기화
PermList=/root/scripts/perm.list		# 점검 대상 파일 목록
Result=/root/scripts/report3.txt		# 점검 결과
TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
> $Result																	# 파일 실행 시 점검 결과 초기화
> $TMP1																		# 파일 실행 시 임시 파일 초기화
> $TMP2																		# 파일 실행 시 임시 파일 초기화
# 2) 파일 유무 점검
for ChkFile in `cat $PermList | awk '{print $1}'`
do
		if [ ! -f $ChkFile ] ; then
				echo "[ WARN ] '$ChkFile' not found."
				exit 1
				break
		fi
done
# 3) 점검 스크립트
cat $PermList | while read FName FUser FPermNum FPermChar
do
		if [ ! -f $FName ] ; then
				echo "[ ERROR ] $FName not found" >> $Result
				echo >> $Result
				continue
		else
				find $FName -type f -perm -$FPermNum -ls \
				| fgrep -v $FPermChar > $TMP1
				if [ -s $TMP1 ] ; then 
						BadPerm=$(cat $TMP1 | awk '{print $3}')
						WARN "$FPermNum : $FName ($BadPerm)" >> $Result
				else
						GoodPerm=$(find $FName -type f -ls | awk '{print $3}')
						OK "$FName permission($FPermNum 이하) : $GoodPerm" >> $Result
				fi
				find $FName -type f -user $FUser -ls > $TMP2
				if [ -s $TMP2 ] ; then
						GoodUser=$(cat $TMP2 | awk '{print $5}')
						OK "$FName owner : $GoodUser" >> $Result
				else
						BadUser=$(find $FName -type f -ls | awk '{print $5}')
						WARN "$FName owner : $BadUser" >> $Result
						echo >> $Result
				fi
				FileUser=$(ls -l $FName | awk '{print $3}') 
				if [ $FileUser = $FUser ] ; then
						echo "ㄴ-----> Authorized User matched." >> $Result
						echo >> $Result
				else
						echo "ㄴ-----> Authorized User does not matched." >> $Result
						echo >> $Result
				fi
		fi
done