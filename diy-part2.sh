#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd
git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
src-git kenzo https://github.com/kenzok8/openwrt-packages
src-git small https://github.com/kenzok8/small
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/feeds/luci/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
#design
git clone https://github.com/gngpp/luci-theme-design.git  package/luci-theme-design
git clone https://github.com/gngpp/luci-app-design-config.git package/luci-app-design-config

# 禁用ipv6前缀
#sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# 取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改主机名称
#sed -i 's/OpenWrt/HIWIFI-HC5962/g' package/base-files/files/bin/config_generate

# 修改版本号
sed -i "s/OpenWrt /茉晴 $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改默认wifi名称ssid为tymishop
#sed -i 's/ssid=OpenWrt/ssid=tymishop/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#开启MU-MIMO
sed -i 's/mu_beamformer=0/mu_beamformer=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#wifi加密方式，没有是none
#sed -i 's/encryption=none/encryption=psk2/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

#wifi密码
#sed -i 's/key=15581822425/key=gds.2021/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 删除软件包
rm -rf package/lean/luci-theme-argon
