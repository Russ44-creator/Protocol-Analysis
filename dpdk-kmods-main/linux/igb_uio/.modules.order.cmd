cmd_/home/nsq/DPDk/dpdk-kmods-main/linux/igb_uio/modules.order := {   echo /home/nsq/DPDk/dpdk-kmods-main/linux/igb_uio/igb_uio.ko; :; } | awk '!x[$$0]++' - > /home/nsq/DPDk/dpdk-kmods-main/linux/igb_uio/modules.order