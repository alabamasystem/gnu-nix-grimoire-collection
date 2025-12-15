#!/usr/bin/env bash

# DO NOT USE. 
# Just pick parts of it if you need it
# runs Determinate Nix OS 25:11 and put the stdin into a log file, so is going to run, you are going to see the booting messages (<<NixOS Phase 1>>, <<Nixos Phase 2>>) through the log defined in bash variable "${log}"
# you need to take out the isos bzImage and initrd and put them into a folder for this to work. You need to extract those system artifacts and store them outside the ISO

# open andes is trying to run this thing with networking capabilities plugging the virtual nix machine into a private virtual network (lemulink)
# cmd appends the grub expression to boot the machine, this renders UEFI support useless. You know, Secure Boot. That shit they put in Battlefield 6. That fucking stupid shit nobody likes.
# If a security/safety control can be circumvented, of what use is the control?
# information security is not about putting useless guardrails
# Dumb fucks.

# fail fast and loud
set -euo pipefail

vm_name="gnu-nix-sinix-alice"
virtual_storage_unit="/home/control/vhdd/gnu-nix-sinix-alice.qcow2"
virtual_image_disk="/home/control/isos/determinate-nix-operating-system.iso"
random_access_memory_allocated="4096"
central_process_units="4"
media_access_control_address="e8:b4:70:c0:00:a1"
log="/home/control/vhdd/gnu-nix-sinix-alice.log"

determinate_nix_extracted="/home/control/eleriel-workbench/determinate-nix-extracted"
determinate_kernel="${determinate_nix_extracted}/bzImage"
determinate_initrd="${determinate_nix_extracted}/initrd"
cmd="init=/nix/store/x82w1lpk76v7kjsd0x9f0lc67bykkcia-nixos-system-nixos-25.11.20251117.89c2b23/init root=LABEL=nixos-minimal-25.11-x86_64 console=ttyS0,115200n8 loglevel=4"


exec qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-smp "${central_process_units}" out
	-m "${random_access_memory_allocated}" \
	-daemonize \
	-display none \
	-serial file:"${log}" \
	-kernel "${determinate_kernel}" \
	-initrd "${determinate_initrd}" \
	-append "${cmd}" \
	-netdev tap,id=lemu-bridge,ifname=lemu-tap,script=no,downscript=no \
	-device virtio-net-pci,netdev=lemu-bridge,mac="${media_access_control_address}" \
	-drive file="${virtual_storage_unit}",if=virtio,cache=writeback \
	-drive media=cdrom,file="${virtual_image_disk}",readonly=on
