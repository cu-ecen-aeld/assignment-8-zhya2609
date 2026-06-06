
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = 35863ce907484f94347ad18b2f136f7844a86528
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-zhya2609.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) -C $(@D)/finder-app clean
	$(MAKE) -C $(@D)/finder-app all CC=$(TARGET_CC) CROSS_COMPILE=$(TARGET_CROSS)
	$(MAKE) -C $(@D)/server clean
	$(MAKE) -C $(@D)/server all CC=$(TARGET_CC) CROSS_COMPILE=$(TARGET_CROSS)
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf
	$(INSTALL) -m 0755 $(@D)/finder-app/writer          $(TARGET_DIR)/usr/bin/writer
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh       $(TARGET_DIR)/usr/bin/finder.sh
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh  $(TARGET_DIR)/usr/bin/finder-test.sh
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket       $(TARGET_DIR)/usr/bin/aesdsocket
	$(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load  $(TARGET_DIR)/usr/bin/aesdchar_load
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/bin/aesdchar_unload
	$(INSTALL) -D -m 0755 $(AESD_ASSIGNMENTS_PKGDIR)/S98aesdchar $(TARGET_DIR)/etc/init.d/S98aesdchar
endef

$(eval $(kernel-module))
$(eval $(generic-package))
