#!/bin/bash

HostIP="ceres@10.10.33.44"
dpasswd="cddb@021"
dbtable=$1
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
send "psql -d postgres -U ceres\r"
expect eof
EOF
}


if [ ! $1 ]
then
    exit 1
    
else 
    import_csv_to_psql>table.txt
    
    stat=$(grep "does not exist" table.txt)

    if [ ${#stat} = 0 ]
    then
        status="0"
    else
        status="1"
    fi

    return $status
fi