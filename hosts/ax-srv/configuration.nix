{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];


    # TODO if needed, update the following line from /etc/nixos/configuration.nix
    # boot.initrd.luks.devices."luks-f43e8971-1fb7-4d8c-be86-c8162a78d104".device = "/dev/disk/by-uuid/f43e8971-1fb7-4d8c-be86-c8162a78d104";
    networking.hostName = "ax-srv"; # Define your hostname.


    services.openssh = {
      enable = true;
    };

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };


    # The firewall is enabled by default on NixOS. Still, explicitly ensure it is enabled
    networking.firewall.enable = true;
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 2283 ];
    # networking.firewall.allowedUDPPorts = [ ... ];


    environment.systemPackages = with pkgs; [
      htop
      podman-compose
      wget
    ];


    system.stateVersion = "25.05"; # Did you read the comment?
}
