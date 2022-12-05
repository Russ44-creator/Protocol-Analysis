#!/bin/bash

HostIP="ceres@10.10.33.44"
dpasswd="cddb@021"

files=$1
dbtable = $2
import_csv_to_psql(){
/usr/bin/expect << EOF
spawn ssh   $HostIP
expect "(yes/no)?" { 
    send "yes\r"
    sleep 10
    }
sleep 10
expect "password:" { 
    send "$dpasswd\r"
    sleep 10
    }
sleep 1
send "export PATH=$PATH:/usr/local/cddb/bin\r"
sleep 1
send "export LD_LIBRARY_PATH=/usr/local/cddb/lib:$LD_LIBRARY_PATH\r"
sleep 1

send "psql -d DPDK -U ceres\r"
sleep 1
send "COPY $dbtable from '/home/ceres/$files' WITH DELIMITER ',' NULL AS '' CSV HEADER QUOTE AS '|';\r"; 
expect eof
EOF
}

echo $1
if [ ! $1 ]
then
    exit 1
    
else 
    scp $1 $HostIP:"/home/ceres"
    import_csv_to_psql
    ssh $HostIP "rm -rf $1"
fi