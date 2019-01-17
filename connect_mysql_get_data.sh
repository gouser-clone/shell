#!/bin/sh
MYSQL_HOST='*.*.*.*.*'
MYSQL_USER='****'
MYSQL_PASSWD='*****'
MYSQL_DB='*****'
MYSQL_PORT='*****'
COMMAND="mysql -h${MYSQL_HOST} -P${MYSQL_PORT} -u${MYSQL_USER} -p${MYSQL_PASSWD} ${MYSQL_DB}"

//* * * * * sh -x /home/oicq/wb/sync_data_svr/tools/wb_note.sh > /home/oicq/wb/note.log 2>&1 & 
//注释里的是可以手动执行的，但是，在cron 是报错的
/*
while read -a row
do
        /home/oicq/wb/sync_data_svr/tools/hash_data_cache_tool 0 ${row[0]} ${row[1]}
done< <(echo "select proc_id,unit_id from wb_note;" | ${COMMAND}) | awk 'NR>1'
*/
//解决办法：把数据输出到文件，然后执行
DATUM= ${COMMAND} -e "select proc_id,unit_id from wb_note;" | awk 'NR>1' >/home/oicq/wb/un_pr.log
while read -a row
do
//执行脚本
/home/oicq/wb/sync_data_svr/tools/hash_data_cache_tool 2 ${row[0]} ${row[1]}

/home/oicq/wb/sync_data_svr/tools/modify_status 0 ${row[1]} 2

done < /home/oicq/wb/un_pr.log


