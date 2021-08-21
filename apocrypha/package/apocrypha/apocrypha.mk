################################################################################
#
# apocrypha
#
################################################################################
APOCRYPHA_VERSION = 4e7dada
APOCRYPHA_SITE = https://github.com/ptpb/apocrypha.git
APOCRYPHA_SITE_METHOD = git
APOCRYPHA_LICENSE = GPL-3.0+
APOCRYPHA_DEPENDENCIES = gnutls

define APOCRYPHA_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define APOCRYPHA_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/apocrypha $(TARGET_DIR)/usr/bin

	$(INSTALL) -D -m 0755 $(BR2_EXTERNAL_APOCRYPHA_PATH)/package/apocrypha/S99apocrypha \
		$(TARGET_DIR)/etc/init.d/S99apocrypha
endef

$(eval $(generic-package))
