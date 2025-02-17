#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="ValenSEB"
iso_label="ValenSEB_$(date +%Y%m)"
iso_publisher="ValenSEB <https://github.com/keyaedisa>"
iso_application="Valen Server Edition Baseline"
iso_version="0.1c"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="erofs"
airootfs_image_tool_options=('-zlzma,9' -E ztailpacking)
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/root"]="0:0:750"
)
