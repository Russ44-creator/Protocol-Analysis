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
	{ 0x32e21920, "module_layout" },
	{ 0x961710e2, "param_ops_charp" },
	{ 0x59d2a97, "param_ops_int" },
	{ 0x233f929e, "pci_unregister_driver" },
	{ 0xf2bb7d9, "__pci_register_driver" },
	{ 0xe2d5255a, "strcmp" },
	{ 0x92997ed8, "_printk" },
	{ 0x400d1b40, "_dev_warn" },
	{ 0xde80cd09, "ioremap" },
	{ 0x87cec3d1, "dma_free_attrs" },
	{ 0x1d0107ac, "dma_alloc_attrs" },
	{ 0xb9a2da75, "__uio_register_device" },
	{ 0xdda5fd5d, "sysfs_create_group" },
	{ 0x35b97737, "dma_set_coherent_mask" },
	{ 0x7eae295f, "dma_set_mask" },
	{ 0x8d929026, "pci_enable_device" },
	{ 0xf35141b2, "kmem_cache_alloc_trace" },
	{ 0x26087692, "kmalloc_caches" },
	{ 0xbbc0ee83, "pci_msi_unmask_irq" },
	{ 0x726fd5db, "pci_intx" },
	{ 0xc3a218a0, "pci_msi_mask_irq" },
	{ 0xe66b5734, "pci_cfg_access_unlock" },
	{ 0x129c249f, "pci_cfg_access_lock" },
	{ 0x2dc7fc5c, "irq_get_irq_data" },
	{ 0x79161eb9, "_dev_err" },
	{ 0x85c21616, "__dynamic_dev_dbg" },
	{ 0x696f32fb, "pci_irq_vector" },
	{ 0x5f49d55d, "pci_alloc_irq_vectors_affinity" },
	{ 0xe6e002cf, "_dev_info" },
	{ 0x92d5838e, "request_threaded_irq" },
	{ 0x1e323c29, "pci_set_master" },
	{ 0x4b4a2767, "pci_check_and_mask_intx" },
	{ 0xef51fc28, "uio_event_notify" },
	{ 0x87a21cb3, "__ubsan_handle_out_of_bounds" },
	{ 0x37a0cba, "kfree" },
	{ 0xfb14ff3c, "pci_disable_device" },
	{ 0xedc03953, "iounmap" },
	{ 0x7307c63a, "uio_unregister_device" },
	{ 0x4ca7c5e3, "sysfs_remove_group" },
	{ 0x822531c7, "pci_free_irq_vectors" },
	{ 0xc1514a3b, "free_irq" },
	{ 0xec6bfac, "pci_clear_master" },
	{ 0x656e4a6e, "snprintf" },
	{ 0x65487097, "__x86_indirect_thunk_rax" },
	{ 0xd0da656b, "__stack_chk_fail" },
	{ 0xd80f667b, "pci_enable_sriov" },
	{ 0x20d77385, "pci_disable_sriov" },
	{ 0x5b8239ca, "__x86_return_thunk" },
	{ 0xda7f52f2, "pci_num_vf" },
	{ 0x5c3c7387, "kstrtoull" },
	{ 0xbdfb6dbb, "__fentry__" },
};

MODULE_INFO(depends, "uio");


MODULE_INFO(srcversion, "765AF497792C1DC055882BF");
