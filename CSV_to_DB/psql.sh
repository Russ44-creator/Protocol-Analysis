#!/bin/bash

HostIP="root@10.10.33.45"
dpasswd="Hcjr@123"

import_csv_to_psql(){
/usr/bin/expect << EOF
spawn ssh   $HostIP
expect "(yes/no)?" { 
    send "yes\n"
    sleep 10
    }
sleep 10
expect "password:" { 
    send "$dpasswd\n"
    sleep 10
    }
sleep 1
send "cd /home/ceres\r"
sleep 1
send "su ceres\r"
sleep 1
send "export PATH=$PATH:/usr/local/cddb/bin\r"
sleep 1
send "export LD_LIBRARY_PATH=/usr/local/cddb/lib:$LD_LIBRARY_PATH\r"
sleep 1

send "psql -d DPDK -U ceres\r"
sleep 1
send "COPY test from /root/test.csv WITH DELIMITER ',' NULL AS '' CSV HEADER QUOTE AS '|'\r"; 
expect eof
EOF
}

echo $1
if [ ! $1 ]
then
    exit 1
    
else 
    scp $1 $HostIP:"/root/"
    import_csv_to_psql
    ssh $HostIP "rm -rf $1"
fi