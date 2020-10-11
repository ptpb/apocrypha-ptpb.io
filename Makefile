include config.mk

ROOT_DIR=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ARCHIVE=$(ROOT_DIR)/build/images/buildroot.tar.gz

all: $(ARCHIVE)

$(ARCHIVE): export BR2_EXTERNAL=$(ROOT_DIR)/$(EXTERNAL_NAME)
$(ARCHIVE): buildroot-$(BUILDROOT_VERSION)
	make \
		-C $(ROOT_DIR)/buildroot-$(BUILDROOT_VERSION) \
		O=$(ROOT_DIR)/build \
		kvm_defconfig

	make \
		-C $(ROOT_DIR)/buildroot-$(BUILDROOT_VERSION) \
		O=$(ROOT_DIR)/build \
		all

buildroot-$(BUILDROOT_VERSION): buildroot-$(BUILDROOT_VERSION).tar.gz
	tar xzf $<

buildroot-$(BUILDROOT_VERSION).tar.gz:
	curl --output $@ https://buildroot.org/downloads/$@

clean:
	rm -rf $(ROOT_DIR)/build

.PHONY: clean
