print_usage()
{
    echo "Usage: function_test.sh -[option]"
    echo "  -[option]:"
    echo "  -EAL            1.验证EAL功能正常"
    echo "  -setHugepages   2.验证大页内存功能是否正常"
    echo "  -timer          3.验证定时器功能是否正常"
    echo "  -ring           4.验证无锁环功能是否正常"
    echo "  -QOS            5.验证QOS功能是否正常"
    echo "  -classify       6.验证classify功能是否正常"
    echo "  -http           7.验证HTTP会话管理功能是否正常"
    echo "  -ssl            8.验证ssl会话管理功能是否正常"
    echo "  -ip             9.验证IP会话分解与重组子模块功能是否正常"
    echo "  -tcp            10.验证tcp会话分解与重组子模块功能是否正常"
    echo "  -udp            11.验证udp会话分解与重组子模块功能是否正常"
    echo "  -egp            12.验证egp会话分解与重组子模块功能是否正常"
    echo "  -igp            13.验证igp会话分解与重组子模块功能是否正常"
    echo "  -gre            14.验证gre会话分解与重组子模块功能是否正常"
    echo "  -esp            15.验证esp会话分解与重组子模块功能是否正常"
    echo "  -l2tp           16.验证l2tp会话分解与重组子模块功能是否正常"
    echo "  -sctp           17.验证sctp会话分解与重组子模块功能是否正常"
    echo "  -gtp            18.验证gtp会话分解与重组子模块功能是否正常"
    echo "  -app            19.验证特定应用的数据包是否正常识别 "
    echo "  -diy            20.验证自定义格式数据包是否正常识别 "
    echo "  -ports          21.查看网卡绑定状态"
    echo "  -tuple          22.查看ip五元组"


}

BASE_PATH=$(pwd)

if [ $# -gt 1 ]
then
    print_usage
    exit
fi


if [ $1x = "-EAL"x ]
then
    cd $BASE_PATH/function_test/helloworld
    make all
    cd build
    ./helloworld -l 0-3 -n 4
    echo "EAL功能测试成功"
elif [ $1x = "-setHugepages"x ]
then
    ARCH=$(uname -m)
    mkdir -p /dev/hugepages
    mountpoint -q /dev/hugepages || mount -t hugetlbfs nodev /dev/hugepages

    if [ $ARCH == "x86_64" ]
    then
        echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
    elif [ $ARCH == "aarch64" ]
    then
        echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-524288kB/nr_hugepages
        echo 64 > /sys/devices/system/node/node1/hugepages/hugepages-524288kB/nr_hugepages
        echo 64 > /sys/devices/system/node/node2/hugepages/hugepages-524288kB/nr_hugepages
        echo 64 > /sys/devices/system/node/node3/hugepages/hugepages-524288kB/nr_hugepages
        echo 64 > /sys/devices/system/node/node4/hugepages/hugepages-524288kB/nr_hugepages
        echo 64 > /sys/devices/system/node/node5/hugepages/hugepages-524288kB/nr_hugepages

    elif [ $ARCH == "sw_64" ]
    then
        echo "on sw_64"
        echo 512 >/sys/devices/system/node/node0/hugepages/hugepages-8192kB/nr_hugepages
        echo 512 >/sys/devices/system/node/node1/hugepages/hugepages-8192kB/nr_hugepages
    else
    echo "unsupported arch."
    exit 1
    fi
    cat /proc/meminfo | grep -i huge
    echo "大页内存设置成功"
elif [ $1x = "-timer"x ]
then
    cd $BASE_PATH/function_test/timer
    make all
    cd build
    ./timer -l 0-3 -n 4
    echo "定时器功能测试成功"
elif [ $1x = "-ring"x ]
then
    cd $BASE_PATH/function_test/ring
    make all
    echo "测试程序已准备完毕，请开启两个新终端分别执行"
    echo "1) cd " $BASE_PATH"/function_test/ring/build &&  ./ring -l 0-1 -n 4 --proc-type=primary"
    echo "   "
    echo "2) cd " $BASE_PATH"/function_test/ring/build &&  ./ring -l 2-3 -n 4 --proc-type=secondary"
    echo "   "
    
elif [ $1x = "-classify"x ]
then
    echo "该项测试需要绑定两个dpdk设备,请确保该条件满足"
    cd $BASE_PATH/function_test/flow_classify
    make all
    cd build
    ./flow_classify  -c 4 -n 4 -- --rule_ipv4="../ipv4_rules_file.txt"
    echo "classify功能测试成功"
elif [ $1x = "-QOS"x ]
then
    cd $BASE_PATH/function_test/qos_meter
    make all
    cd build
    ./qos_meter -l 0 -n 4 --proc-type auto -- -p 0x1
    echo "QOS功能测试成功"

elif [ $1x = "-http"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/1_http_packet.pcap
    echo "http会话管理功能测试成功"

elif [ $1x = "-ssl"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/SSL.pcapng
    echo "ssl会话管理功能测试成功"
elif [ $1x = "-ip"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/SSL.pcapng
    echo "IP会话分解与重组子模块功能测试成功"
elif [ $1x = "-tcp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/TCP.pcapng
    echo "TCP会话分解与重组子模块功能测试成功"
elif [ $1x = "-udp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/UDP.pcapng
    echo "UDP会话分解与重组子模块功能测试成功"
elif [ $1x = "-egp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/EGP.pcapng
    echo "EGP会话分解与重组子模块功能测试成功"
elif [ $1x = "-igp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/IGP.pcapng
    echo "IGP会话分解与重组子模块功能测试成功"
elif [ $1x = "-gre"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/gre.pcapng
    echo "GRE会话分解与重组子模块功能测试成功"
elif [ $1x = "-esp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/ESP.pcapng
    echo "ESP会话分解与重组子模块功能测试成功"
elif [ $1x = "-l2tp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/L2TP.pcapng
    echo "L2TP会话分解与重组子模块功能测试成功"
elif [ $1x = "-sctp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/SCTP.pcapng
    echo "SCTP会话分解与重组子模块功能测试成功"
elif [ $1x = "-gtp"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/GTPv2.pcapng
    echo "GTP会话分解与重组子模块功能测试成功"
elif [ $1x = "-app"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/visualcode.pcapng
    echo "特定应用数据包识别测试成功"
elif [ $1x = "-diy"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/diypackage.cap.gz
    echo "自定义格式数据包识别测试成功"
elif [ $1x = "-ports"x ]
then
    dpdk-devbind.py  --status 
elif [ $1x = "-tuple"x ]
then
    cd $BASE_PATH/PcapPlusPlus/Examples/ProtocolAnalysis/Bin
    ./ProtocolAnalysis  $BASE_PATH/pcap测试网络包/SSL.pcapng
    ls *.txt
    echo "查看五元组测试成功"
else
    echo $1
    print_usage
fi