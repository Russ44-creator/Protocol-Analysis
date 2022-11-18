#!/bin/bash	

SOURCE_PATH=$(cd $(dirname $0); pwd)
DPDK_SW_PATH=$SOURCE_PATH"/"
DPDK_ARM_PATH=$SOURCE_PATH"/DPDK/dpdk-arm"
Protocolstack_PATH=$SOURCE_PATH"/PcapPlusPlus"
Yaml_PATH=$SOURCE_PATH"/yaml-cpp-yaml-cpp-0.7.0"
igb_uio_PATH=$SOURCE_PATH"/dpdk-kmods-main/linux/igb_uio"
str="========================"





#判断当前环境
Current_Environment=$(uname -r)
echo $Current_Environment
array=(${Current_Environment//-/ })  
extension=${array[-1]}

# echo $extension
# if [ $extension = "azure" ]
# then
#     echo "azure"
# el

if [ $extension = "sw64" ]
then
    echo "sw64"
    DPDK_PATH=$DPDK_SW_PATH
elif [ $extension = "aarch64" ]
then 
    echo "aarch64"
    DPDK_PATH=$DPDK_ARM_PATH
else
    echo "x86"
    DPDK_PATH=$DPDK_ARM_PATH
fi



dpdk_install()
{
    echo "$str""编译安装dpdk""$str"
    cd DPDK_PATH
    if [ -d "build" ]
    then
        cd build
        ninja uninstall
        cd ..
        rm -rf build
    fi
    if [$extension = "aarch64"]
    then
        meson -Dmachine=generic build
    else
        meson build
    fi
    cd build
    ninja && ninja install
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
    ./configure-linux.sh n y $DPDK_PATH
    make clean
    make all
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
    make
    make install
    echo "$str""yaml编译安装完成""$str
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

    echo "$str""yaml卸载完成""$str
}

Protocol_Analysis_install()
{
    echo "$str""编译安装Protocol_Analysis""$str"
    cd $Protocol_Analysis_PATH
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

print_usage()
{
    echo "Usage: project_install.sh -[option]"
    echo "  -[option]:"
    echo "  -help      查看用法"
    echo "  -install   安装dpdk,Protocolstack,Yaml,Protocol_Analysis"
    echo "  -uninstall 卸载dpdk,Protocolstack,Yaml,Protocol_Analysis"
    echo "  -insmod    插入igb_uio.ko "
}


if [ $# -gt 1 ]
then
    print_usage
    exit
fi


if [ $1x = "-install"x ]
then
    dpdk_install
    Protocolstack_install
    yaml_install
    Protocol_Analysis_install
elif [ $1x = "-uninstall"x ]
then
    dpdk_uninstall
    Protocolstack_uninstall
    yaml_unstall
elif [ $1x = "insmod"x ]
then
    insmod_uio
else
    echo $1
    print_usage
fi