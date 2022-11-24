mkdir -p /dev/hugepages
mountpoint -q /dev/hugepages || mount -t hugetlbfs nodev /dev/hugepages
echo 512 >/sys/devices/system/node/node0/hugepages/hugepages-8192kB/nr_hugepages

echo "大页设置成功"