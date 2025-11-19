## 11/19/2025

# DO NOT APPLY. Experimental.

```nix
# Operates the baseline networking line used to remote work
networking.networkmanager.enable = true;

# Operates the new kernel virtual network infrastructure
networking.useNetworkd = true;
```

Declare a new kernel virtual network bridge device. In practical terms, this is a new virtual network card.
```nix
# Lemu-Link: Kernel virtual bridge network device
systemd.network.netdevs = {
  "0x00-lorienlink-0" = {
    netdevConfig = {
      Kind = "bridge";
      Name = "lorienlink-0";
      MACAddress = "E8:B4:70:C0:00:01";
    };
  }; 
};
```
