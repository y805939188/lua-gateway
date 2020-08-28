#!/usr/bin/env bash

# ${LOG_REMAIN_DAYS:-0} 是shell的语法，表示获取环境变量LOG_REMAIN_DAYS的值，如果该环境变量为空，则使用-后面的值(即0)
# 这样就可以在需要调整日志保留天数的时候，调整部署时的环境变量即可，无需重新生成镜像文件。
# 此处LOG_REMAIN_DAYS表示删除LOG_REMAIN_DAYS+1天以外的文件，比如这个值为2，表示保留3天(72小时)之内的文件。
crontab << EOF
1 * * * * sh /usr/local/log_rotate.sh ${LOG_REMAIN_DAYS:-6}
EOF
crond    # 该命令是启动cronjob，用来定时执行上面的任务

/usr/local/openresty/bin/openresty -c conf/nginx.conf -g "daemon off;"
