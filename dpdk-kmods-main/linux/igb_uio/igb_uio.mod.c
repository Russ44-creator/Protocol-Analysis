#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/elfnote-lto.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;
BUILD_LTO_INFO;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

#ifdef CONFIG_RETPOLINE
MODULE_INFO(retpoline, "Y");
#endif

static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0xc4162456, "module_layout" },
	{ 0xe40e7b0a, "param_ops_charp" },
	{ 0x8028405, "param_ops_int" },
	{ 0x25255b41, "pci_unregister_driver" },
	{ 0x43387c54, "__pci_register_driver" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x92997ed8, "_printk" },
	{ 0x658303e5, "_dev_warn" },
	{ 0xde80cd09, "ioremap" },
	{ 0x23b879e8, "dma_free_attrs" },
	{ 0x9a472e11, "dma_alloc_attrs" },
	{ 0x3100ae6b, "__uio_register_device" },
	{ 0xed9d1a14, "sysfs_create_group" },
	{ 0x1584f964, "dma_set_coherent_mask" },
	{ 0x961a8b82, "dma_set_mask" },
	{ 0x86e020fb, "pci_enable_device" },
	{ 0xa926a2db, "kmem_cache_alloc_trace" },
	{ 0x57b41c5c, "kmalloc_caches" },
	{ 0xd66eb663, "pci_msi_unmask_irq" },
	{ 0x84858208, "pci_intx" },
	{ 0x9dcf5aa2, "pci_msi_mask_irq" },
	{ 0x82545ed0, "pci_cfg_access_unlock" },
	{ 0xfc4e0759, "pci_cfg_access_lock" },
	{ 0x133bf547, "irq_get_irq_data" },
	{ 0x8fd90bcc, "_dev_notice" },
	{ 0xb7f3306b, "_dev_err" },
	{ 0x97f4a8b5, "__dynamic_dev_dbg" },
	{ 0x21a576ae, "pci_irq_vector" },
	{ 0xe7d9e28c, "pci_alloc_irq_vectors_affinity" },
	{ 0x1da88f1a, "_dev_info" },
	{ 0x92d5838e, "request_threaded_irq" },
	{ 0xc296c668, "pci_set_master" },
	{ 0x3567b73f, "pci_check_and_mask_intx" },
	{ 0xb2f1e7e2, "uio_event_notify" },
	{ 0x87a21cb3, "__ubsan_handle_out_of_bounds" },
	{ 0x37a0cba, "kfree" },
	{ 0x304a3845, "pci_disable_device" },
	{ 0xedc03953, "iounmap" },
	{ 0xd123d16d, "uio_unregister_device" },
	{ 0xae8901e4, "sysfs_remove_group" },
	{ 0xa35154ba, "pci_free_irq_vectors" },
	{ 0xc1514a3b, "free_irq" },
	{ 0xd6a3856c, "pci_clear_master" },
	{ 0x656e4a6e, "snprintf" },
	{ 0x65487097, "__x86_indirect_thunk_rax" },
	{ 0xd0da656b, "__stack_chk_fail" },
	{ 0x2a5d3d56, "pci_enable_sriov" },
	{ 0x6dd6997b, "pci_disable_sriov" },
	{ 0x5b8239ca, "__x86_return_thunk" },
	{ 0x1ac1f933, "pci_num_vf" },
	{ 0x5c3c7387, "kstrtoull" },
	{ 0xbdfb6dbb, "__fentry__" },
};

MODULE_INFO(depends, "uio");


MODULE_INFO(srcversion, "3AD74E218C6B7CA098CB1F1");
