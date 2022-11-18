#include <linux/module.h>
#define INCLUDE_VERMAGIC
#include <linux/build-salt.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

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
	{ 0x19fdd0c3, "module_layout" },
	{ 0x44569072, "param_ops_charp" },
	{ 0x69e052b6, "param_ops_int" },
	{ 0xbe7c45c2, "pci_unregister_driver" },
	{ 0xeee3b50f, "__pci_register_driver" },
	{ 0xe2d5255a, "strcmp" },
	{ 0xc5850110, "printk" },
	{ 0xdeeda190, "_dev_warn" },
	{ 0xde80cd09, "ioremap" },
	{ 0xe1a32858, "dma_free_attrs" },
	{ 0x1ac9bfe8, "dma_alloc_attrs" },
	{ 0xf94a0a8a, "__uio_register_device" },
	{ 0xb707d6ba, "sysfs_create_group" },
	{ 0xefb3435, "dma_set_coherent_mask" },
	{ 0xb1d8464, "dma_set_mask" },
	{ 0x807cd017, "pci_enable_device" },
	{ 0xd1ff3d1f, "kmem_cache_alloc_trace" },
	{ 0x5f3af44c, "kmalloc_caches" },
	{ 0x222a8fb5, "pci_msi_unmask_irq" },
	{ 0xf00a90d9, "pci_intx" },
	{ 0x5908af4a, "pci_msi_mask_irq" },
	{ 0xcfe9cd08, "pci_cfg_access_unlock" },
	{ 0x31b0b986, "pci_cfg_access_lock" },
	{ 0x310e6cce, "irq_get_irq_data" },
	{ 0x781adcb9, "_dev_notice" },
	{ 0x69fee9d4, "_dev_err" },
	{ 0x1497b248, "__dynamic_dev_dbg" },
	{ 0xbaee88a5, "pci_irq_vector" },
	{ 0xaef3ec72, "pci_alloc_irq_vectors_affinity" },
	{ 0xbcc4800a, "_dev_info" },
	{ 0x92d5838e, "request_threaded_irq" },
	{ 0xa914e070, "pci_set_master" },
	{ 0x8f8a5af, "pci_check_and_mask_intx" },
	{ 0x3937d126, "uio_event_notify" },
	{ 0x37a0cba, "kfree" },
	{ 0x28cb89c6, "pci_disable_device" },
	{ 0xedc03953, "iounmap" },
	{ 0xec031f8a, "uio_unregister_device" },
	{ 0xf816703d, "sysfs_remove_group" },
	{ 0x193bbf61, "pci_free_irq_vectors" },
	{ 0xc1514a3b, "free_irq" },
	{ 0x177a6151, "pci_clear_master" },
	{ 0x656e4a6e, "snprintf" },
	{ 0x2ea2c95c, "__x86_indirect_thunk_rax" },
	{ 0xc959d152, "__stack_chk_fail" },
	{ 0x6038a017, "pci_enable_sriov" },
	{ 0xfe269ca2, "pci_disable_sriov" },
	{ 0x59109976, "pci_num_vf" },
	{ 0x5c3c7387, "kstrtoull" },
	{ 0xbdfb6dbb, "__fentry__" },
};

MODULE_INFO(depends, "uio");


MODULE_INFO(srcversion, "3AD74E218C6B7CA098CB1F1");
