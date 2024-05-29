#!/bin/bash

# IP 주소 가져오기
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# 현재 날짜와 시간을 사용하여 결과 파일 이름 생성
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RESULT_FILE="./report/security_check_results_${IP_ADDRESS}_${TIMESTAMP}.log"

# 결과 파일 초기화
> $RESULT_FILE

# 시스템 정보 추가
echo "Security Check Results" >> $RESULT_FILE
echo "IP Address: $IP_ADDRESS" >> $RESULT_FILE
echo "Execution Date: $(date)" >> $RESULT_FILE
echo "---------------------------------------" >> $RESULT_FILE

# 스크립트를 순차적으로 실행
for i in $(seq -f "%02g" 1 74); do
    SCRIPT="U-$i.sh"
    if [ -f "$SCRIPT" ]; then
        START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
        echo "Executing $SCRIPT at $START_TIME..." | tee -a $RESULT_FILE
        echo "---------------------------------------" >> $RESULT_FILE
        echo "Script: $SCRIPT" >> $RESULT_FILE
        echo "Start Time: $START_TIME" >> $RESULT_FILE
        echo "---------------------------------------" >> $RESULT_FILE
        bash "$SCRIPT" >> $RESULT_FILE 2>&1
        END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
        echo "---------------------------------------" >> $RESULT_FILE
        echo "End Time: $END_TIME" >> $RESULT_FILE
        echo "$SCRIPT completed." | tee -a $RESULT_FILE
        echo "---------------------------------------" >> $RESULT_FILE
    else
        echo "$SCRIPT not found, skipping." | tee -a $RESULT_FILE
        echo "---------------------------------------" >> $RESULT_FILE
    fi
done

echo "All scripts executed. Check $RESULT_FILE for details."