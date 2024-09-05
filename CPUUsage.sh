#!/bin/bash

read cpu user nice system previous_idle other < /proc/stat
previous_total=$((user + nice + system + previous_idle))
sleep 0.45
read cpu user nice system idle other < /proc/stat
total=$((user + nice + system + idle))
CPU=$((100 * ((total - previous_total) - (idle - previous_idle)) / (total - previous_total)))
echo $CPU
