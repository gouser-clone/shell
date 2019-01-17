split_file_num=100
mysql_host="*"
mysql_port=*
mysql_user="*"
mysql_pwd="*"

date_time=`date +%Y%m%d`

num=0
while [ $num -lt $split_file_num ]
do
  mysql -h$mysql_host -P$mysql_port -u$mysql_user -p$mysql_pwd -N -e "select count(*) from userinfo.userinfo_$num" >> userinfo.txt ;
  echo "get count"
  num=$((num+1))
done
