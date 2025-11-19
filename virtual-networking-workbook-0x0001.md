## 11/19/2025

# DO NOT APPLY. Experimental.

```nix
# Operates the baseline networking line used to remote work
networking.networkmanager.enable = true;

# Operates the new kernel virtual network infrastructure
networking.useNetworkd = true;
```

```nix
# Lemu-Link: Kernel virtual bridge network device
systemd.network.netdevs = {
  "0x00-lorienlink-0" = {
    netdevConfig = {
      Kind = "bridge";
      Name = "lorienlink-0";
    };
  }; 
};
```
