{ config, lib, pkgs, ... }:

{
  systemd.network.enable = true;
  networking.networkmanager.enable = false;
  networking.useNetworkd = true;

  networking = {
    defaultGateway = {
      address = "10.0.0.1";
      interface = "enp2s0";
    };

    nameservers = [ "10.0.138.188" "1.1.1.1" "8.8.8.8" "8.8.4.4" ];
    domain = "galadriel-uno.erebor.cl";
    search = [ "galadriel-uno.erebor.cl" ];
    interfaces = {

      enp2s0.ipv4.addresses = [{
        address = "10.0.2.8";
        prefixLength = 16;
      }];

      erg01.ipv4.addresses = [{
        address = "10.0.2.8";
        prefixLenght = 16;
      }];

      erg02.ipv4.addresses = [{
        address = "10.0.66.165";
        prefixLength = 16;
      }];

      "erg01" = { macAddress = "e8:b4:70:c0:00:01"; };

      "erg02" = { macAddress = "e8:b4:70:c0:00:02"; };
    };

    vlans = {
      erg01 = {
        id = 1;
        interface = "enp2s0";
      };

      erg02 = {
        id = 2;
        interface = "enp2s0";
      };
    };
  };
}
