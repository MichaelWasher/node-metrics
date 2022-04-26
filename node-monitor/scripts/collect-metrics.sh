#!/bin/bash
set -x

# Resolution in seconds
RESOLUTION=5 
# Duration in seconds (or whatever is acceptable as an argument to "sleep")
DURATION=600

echo "Gathering metrics ..."
mkdir /metrics
rm -Rf /metrics/*

echo "Gathering pidstat ..."
pidstat -p ALL -T ALL -I -l -r  -t  -u -w ${RESOLUTION} > /metrics/pidstat.txt &
PIDSTAT=$!
sar -A ${RESOLUTION} > /metrics/sar.txt &
SAR=$!
bash -c "while true; do date ; ps aux | sort -nrk 3,3 | head -n 20 ; sleep ${RESOLUTION} ; done" > /metrics/ps.txt &
PS=$!
bash -c "while true ; do date ; free -m ; sleep ${RESOLUTION} ; done" > /metrics/free.txt &
FREE=$!
bash -c "while true ; do date ; cat /proc/softirqs; sleep ${RESOLUTION}; done" > /metrics/softirqs.txt &
SOFTIRQS=$!
bash -c "while true ; do date ; cat /proc/interrupts; sleep ${RESOLUTION}; done" > /metrics/interrupts.txt &
INTERRUPTS=$!
sleep "${DURATION}"

kill $PIDSTAT
kill $SAR
kill $PS
kill $FREE
kill $SOFTIRQS
kill $INTERRUPTS