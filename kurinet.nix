{ config, lib, pkgs, ... }:

{
  # 1. Enable systemd-networkd
  systemd.network.enable = true;
  networking.useNetworkd = true;

  # 2. Define the bridge device (creates 20-br0.netdev)
  systemd.network.netdevs."20-br0" = {
    netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
  };

  # 3. Configure the bridge and add interfaces
  systemd.network.networks = {
    # Configure the bridge itself, typically with DHCP
    # (creates 25-br0-dhcp.network)
    "25-br0-dhcp" = {
      matchConfig = { Name = "br0"; };
      networkConfig = { DHCP = "yes" };
    };

    # Enslave your physical Ethernet to the bridge
    # (creates 30-eth-bridge.network)
    "30-eth0-bridge" = {
      # Change "enp2s0" to your actual physical interface name
      matchConfig = { Name = "enp2s0"; };
      networkConfig = { Bridge = "br0"; };
    };
  };
}

# `systemd.network.netdevs."20-br0"` creates the fundamental digital construct. It tells `systemd-networkd` to create a new virtual device named `br0` of the bridge kind
# `systemd.network.networks."25-br0-dhcp": This file configures the br0 interface after it's created, telling it to get its own IP address from your router via DHCP`
  # `systemd.network.networks."30-eth0-bridge" This file matches your physical network card (e.g., enp2s0) and assigns it to the br0 bridge, effectively plugging it into the virtual switch`
