include $(TOPDIR)/rules.mk

PKG_NAME:=mdk4
PKG_VERSION:=4.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aircrack-ng/mdk4.git
PKG_SOURCE_VERSION:=master
PKG_MIRROR_HASH:=skip

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mdk4
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+libnl-core +libnl-genl +libpcap +libpthread
  TITLE:=MDK4 WiFi Testing Tool
  URL:=https://github.com/aircrack-ng/mdk4
endef

define Package/mdk4/description
  MDK4 is a Wi-Fi testing tool from E7mer, ASPj of k2wrlz, it uses the osdep library
  from the aircrack-ng project to inject frames on several operating systems.
endef

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/usr/include \
	-I$(STAGING_DIR)/usr/include/libnl3

TARGET_LDFLAGS += \
	-L$(STAGING_DIR)/usr/lib

MAKE_FLAGS += \
	PREFIX=/usr \
	LIBNL="-lnl-3 -lnl-genl-3"

define Package/mdk4/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/mdk4 $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,mdk4))
