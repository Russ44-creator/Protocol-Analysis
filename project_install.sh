#!/bin/bash	

# export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH

BASE_PATH=$(pwd)
SOURCE_PATH=$(cd $(dirname $0); pwd)
DPDK_SW_PATH="$BASE_PATH/DPDK/dpdk-v21.05-sw64"
DPDK_ARM_PATH="$BASE_PATH/DPDK/dpdk-arm"
DPDK_X86_PATH="$BASE_PATH/DPDK/dpdk-arm"
Protocolstack_PATH="$BASE_PATH/PcapPlusPlus"
Protocol_Analysis_PATH="$BASE_PATH/Protocol_Analysis"
Yaml_PATH="$BASE_PATH/yaml-cpp-yaml-cpp-0.7.0"
igb_uio_PATH="$BASE_PATH/dpdk-kmods-main/linux/igb_uio"
SERVICE_PATH="/etc/systemd/system"
rpms="$BASE_PATH/rpms"
dbimport="$BASE_PATH/CSV_to_DB"
str="========================"

LIBDPDK="libdpdk"

ARCH=$(uname -m)

if [ $ARCH == "x86_64" ]
then
    echo "on x86_64"
    DPDK_PATH=$DPDK_X86_PATH
    echo "/usr/local/lib/x86_64-linux-gnu/" >> /etc/ld.so.conf
    ldconfig
    chmod +x set_hugepages-x86.sh
    ./set_hugepages-x86.sh


elif [ $ARCH == "aarch64" ]
then
    echo "on arm_64"
    DPDK_PATH=$DPDK_ARM_PATH
    echo "/usr/local/lib64" >> /etc/ld.so.conf
    echo "export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig" >> /etc/profile
    source /etc/profile
    ldconfig
    chmod +x set_hugepages-arm.sh
    ./set_hugepages-arm.sh

elif [ $ARCH == "sw_64" ]
then
    echo "on sw_64"
    DPDK_PATH=$DPDK_SW_PATH
    echo "/usr/local/lib64" >> /etc/ld.so.conf
    ldconfig
    LIBDPDK="/usr/local/lib64/pkgconfig/libdpdk-lib.pc"
    echo "export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig" >> /etc/profile
    source /etc/profile
    ldconfig
    chmod +x set_hugepages-sw.sh
    ./set_hugepages-sw.sh
else
   echo "unsupported arch."
   exit 1
fi


install_requirements(){

    echo "$str""安装软件依赖包""$str"
    rpmsdir=""
    if [ $ARCH == "sw_64" ]
    then
        rpmsdir="申威依赖包"
    elif [ $ARCH == "aarch64" ]
    then
        rpmsdir="飞腾依赖包"
    else
    echo "x86系统请直接在线安装依赖包"
    exit 1
    fi
    #rpmsdir="飞腾依赖包"
    # install rpm packages
    for i in `ls $rpms/$rpmsdir`
    do
        if [ ${i##*.} = 'rpm' ]
        then
            echo "安装包$i"
            rpm -ivh $rpms/$rpmsdir/$i
        fi
    done
    # install python packages
    for i in `ls $rpms/$rpmsdir`
    do
        if [ ${i##*.} = 'whl' ]
        then
            echo "安装包$i"
            pip3 install $rpms/$rpmsdir/$i
        fi
    done

}




dpdk_install()
{
    echo "$str""编译安装dpdk""$str"
    cd $DPDK_PATH
    if [ -d "build" ]
    then
        cd build
        ninja uninstall
        cd ..
        rm -rf build
    fi
    if [ $ARCH == "sw_64" ]
    then
        meson -Dexamples=timer,helloworld,flow_classify,qos_meter build
    else
        meson -Dexamples=timer,helloworld,flow_classify,qos_meter -Dmachine=generic build
    fi
    cd build
    ninja -j32 && ninja install
    ldconfig
    echo "$str""dpdk编译安装完成""$str"

}




dpdk_uninstall()
{
    echo "$str""卸载dpdk""$str"
    cd DPDK_PATH
    if [ -d "build" ]
    then
        cd build
        ninja uninstall
        cd ..
        rm -rf build
    fi
    echo "$str""dpdk卸载成功""$str"               
}

Protocolstack_install()
{
    echo "$str""编译安装Protocolstack""$str"
    cd $Protocolstack_PATH
    chmod 777 ./configure-linux.sh
    if [ $ARCH != "x86_64" ]
    then
        sed -i 's/-msse -msse2 -msse3/ /g'  mk/PcapPlusPlus.mk.dpdk
        sed -i 's/-msse -msse2 -msse3 -mssse3/ /g'  Pcap++/Makefile
    fi
    ./configure-linux.sh --dpdk --dpdk-home $DPDK_PATH
    # modify PcapPlusPlus.mk
    #sed -i "s@libdpdk@$LIBDPDK@g" mk/PcapPlusPlus.mk 
    make clean
    make all -j8
    make install
    echo "$str""Protocolstack编译安装完成""$str"
}
Protocolstack_uninstall()
{
    echo "$str""卸载Protocolstack""$str"
    cd $Protocolstack_PATH
    make uninstall
    make clean
    echo "$str""Protocolstack卸载完成""$str"
}

yaml_install()
{
    echo "$str""编译安装yaml""$str"
    cd $Yaml_PATH

    if [ -d "build" ]
    then
        cd build
        make uninstall
        make clean
        cd ..
        rm -rf build
    fi

    mkdir build
    cd build
    cmake ..
    make -j32
    make install
    echo "$str""yaml编译安装完成""$str"
}

yaml_unstall()
{
    echo "$str""卸载yaml""$str"
    cd $Yaml_PATH

    if [ -d "build" ]
    then
        cd build
        make uninstall
        make clean
        cd ..
        rm -rf build
    fi

    echo "$str""yaml卸载完成""$str"
}

Protocol_Analysis_install()
{
    echo "$str""编译安装Protocol_Analysis""$str"
    cp $Protocolstack_PATH/mk/PcapPlusPlus.mk /usr/local/etc/
    cd $Protocol_Analysis_PATH
    if [ ! -d "build" ]; then
    mkdir build
    fi
    if [ $ARCH != "x86_64" ]
    then
        sed -i 's/-static-libstdc++/-lstdc++/g'  Makefile
    fi
    make clean
    make all

    
    echo "$str""Protocol_Analysis编译安装完成""$str"
}

insmod_uio()
{
    echo "uio路径:"$igb_uio_PATH
    cd $igb_uio_PATH
    make all
    modprobe uio
    insmod igb_uio.ko
}

service_install()
{   
    #构建DPDK service
    echo "$str""安装DPDK service""$str"
    cp $BASE_PATH/analysisd.service.template $BASE_PATH/analysisd.service
    sed -i "s@<execute-start>@$Protocol_Analysis_PATH/build/Protocol_Analysis@g" $BASE_PATH/analysisd.service
    # sed -i "s@<config-file>@$Protocol_Analysis_PATH/config.ini@g" $BASE_PATH/analysisd.service
    
    mv $BASE_PATH/analysisd.service ${SERVICE_PATH}/

    #构建python导入数据库service
    echo "$str""安装数据库导入service""$str"
    cp $BASE_PATH/analysisd.service.template $BASE_PATH/importdbd.service
    cp $dbimport/database.ini  /etc/
    sed -i "s@<execute-start>@python3 $dbimport/import_db.py@g" $BASE_PATH/importdbd.service
    # sed -i "s@<config-file>@$Protocol_Analysis_PATH/config.ini@g" $BASE_PATH/analysisd.service
    
    mv $BASE_PATH/importdbd.service ${SERVICE_PATH}/

    echo "$str""service安装完成""$str"
}

service_uninstall()
{
    echo "$str""卸载service""$str"
    sudo rm ${SERVICE_PATH}/analysisd.service
    echo "$str""service卸载完成""$str"
}

print_usage()
{
    echo "Usage: project_install.sh -[option]"
    echo "  -[option]:"
    echo "  -help      查看用法"
    echo "  -install   安装dpdk,Protocolstack,Yaml,Protocol_Analysis"
    echo "  -uninstall 卸载dpdk,Protocolstack,Yaml,Protocol_Analysis"
    echo "  -insmod    插入igb_uio.ko "
    echo "  -install_rpms    安装系统需要依赖软件"
}


if [ $# -gt 1 ]
then
    print_usage
    exit
fi


if [ $1x = "-install"x ]
then
    #dpdk_install
    #Protocolstack_install
    #yaml_install
    Protocol_Analysis_install
    #service_install
elif [ $1x = "-uninstall"x ]
then
    dpdk_uninstall
    Protocolstack_uninstall
    yaml_unstall
    service_uninstall
elif [ $1x = "-install_rpms"x ]
then
    install_requirements
elif [ $1x = "-insmod"x ]
then
    insmod_uio
else
    echo $1
    print_usage
fi
