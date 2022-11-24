#include <linux/build-salt.h>
#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

BUILD_SALT;

MODULE_INFO(vermagic, VERMAGIC_STRING);
MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
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
__used
__attribute__((section("__versions"))) = {
	{ 0x53bb3368, "module_layout" },
	{ 0xed5cb102, "param_ops_charp" },
	{ 0x80ee8389, "param_ops_int" },
	{ 0x61563de2, "pci_unregister_driver" },
	{ 0x5050de18, "__pci_register_driver" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x7c32d0f0, "printk" },
	{ 0xe8f597ec, "_dev_warn" },
	{ 0x6b4b2933, "__ioremap" },
	{ 0xa58e3cf4, "cpu_hwcaps" },
	{ 0x20691e02, "dummy_dma_ops" },
	{ 0x66cfa968, "cpu_hwcap_keys" },
	{ 0x6dfb912f, "arm64_const_caps_ready" },
	{ 0xa82bd70c, "dma_release_from_dev_coherent" },
	{ 0xdcb764ad, "memset" },
	{ 0x41291c8, "dma_alloc_from_dev_coherent" },
	{ 0xc45d5599, "__uio_register_device" },
	{ 0x40c78b01, "sysfs_create_group" },
	{ 0xc5623a8e, "pci_enable_device" },
	{ 0x6d469e0e, "kmem_cache_alloc_trace" },
	{ 0x65feec7, "kmalloc_caches" },
	{ 0xb68ce8ad, "pci_msi_unmask_irq" },
	{ 0x87119a24, "pci_intx" },
	{ 0x3fe3d93c, "pci_msi_mask_irq" },
	{ 0xff773214, "pci_cfg_access_unlock" },
	{ 0xcd5d1fb5, "pci_cfg_access_lock" },
	{ 0xcab88f90, "irq_get_irq_data" },
	{ 0xe0e21730, "__dynamic_dev_dbg" },
	{ 0xf9a3efb9, "__ll_sc_atomic_sub" },
	{ 0xc4dd0573, "_dev_err" },
	{ 0xae3d1e4c, "_dev_notice" },
	{ 0x5c6dd736, "_dev_info" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x72675ba8, "pci_irq_vector" },
	{ 0xa5eacf36, "pci_alloc_irq_vectors_affinity" },
	{ 0x4699a843, "pci_set_master" },
	{ 0x7c97c8a4, "__ll_sc_atomic_add_return" },
	{ 0xb64d6fd9, "pci_check_and_mask_intx" },
	{ 0xc6b14caa, "uio_event_notify" },
	{ 0x37a0cba, "kfree" },
	{ 0xd3f74c5c, "pci_disable_device" },
	{ 0x45a55ec8, "__iounmap" },
	{ 0x909ce75e, "uio_unregister_device" },
	{ 0x1c260d12, "sysfs_remove_group" },
	{ 0xdabe88cc, "pci_free_irq_vectors" },
	{ 0xc1514a3b, "free_irq" },
	{ 0x8a1e4c50, "pci_clear_master" },
	{ 0xec2ac905, "__ll_sc_atomic_sub_return" },
	{ 0x28318305, "snprintf" },
	{ 0x20363294, "pci_enable_sriov" },
	{ 0xe10b1d23, "pci_disable_sriov" },
	{ 0x4bdf7a36, "pci_num_vf" },
	{ 0x60ea2d6, "kstrtoull" },
	{ 0x1fdc7df2, "_mcount" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=uio";


MODULE_INFO(srcversion, "40C295CA132DDB145352055");
