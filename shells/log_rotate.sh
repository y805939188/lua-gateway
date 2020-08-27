#!/usr/bin/env bash

LOG_REMAIN_DAYS=$1 # 从第一个参数当中获取到需要保留的日志天数
LOG_DIR=/usr/local/openresty/nginx/logs # 此处为存放nginx日志的目录，需要按需修改
NGINX_PID_FILE=/usr/local/openresty/nginx/conf/nginx.pid  # 此处为存放nginx进程号的文件路径，用来发送USR1信号
ACCESS_LOG_PREFIX=${LOG_DIR}/access
ERROR_LOG_PREFIX=${LOG_DIR}/error
LAST_HOUR_LOG_FORMAT=$(date -d "-1hour" "+%Y-%m-%d.%H") # 生成上一个小时文件的文件名
mv ${ACCESS_LOG_PREFIX}.log ${ACCESS_LOG_PREFIX}_${LAST_HOUR_LOG_FORMAT}.log # 移动access文件
mv ${ERROR_LOG_PREFIX}.log ${ERROR_LOG_PREFIX}_${LAST_HOUR_LOG_FORMAT}.log # 移动error文件
kill -USR1 $(cat ${NGINX_PID_FILE}) #向nginx发送USR1信号，通知nginx做日志切割
find ${LOG_DIR} -maxdepth 1 -mtime +${LOG_REMAIN_DAYS} -type f | xargs -r rm -v # 此处为自动清理LOG_REMAIN_DAYS天前的日志文件