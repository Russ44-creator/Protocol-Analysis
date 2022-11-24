mkdir -p /dev/hugepages
mountpoint -q /dev/hugepages || mount -t hugetlbfs nodev /dev/hugepages
echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-524288kB/nr_hugepages
echo 64 > /sys/devices/system/node/node1/hugepages/hugepages-524288kB/nr_hugepages
echo 64 > /sys/devices/system/node/node2/hugepages/hugepages-524288kB/nr_hugepages
echo 64 > /sys/devices/system/node/node3/hugepages/hugepages-524288kB/nr_hugepages
echo 64 > /sys/devices/system/node/node4/hugepages/hugepages-524288kB/nr_hugepages
echo 64 > /sys/devices/system/node/node5/hugepages/hugepages-524288kB/nr_hugepages

echo "大页设置成功"