{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];


    # TODO if needed, update the following line from /etc/nixos/configuration.nix
    # boot.initrd.luks.devices."luks-f43e8971-1fb7-4d8c-be86-c8162a78d104".device = "/dev/disk/by-uuid/f43e8971-1fb7-4d8c-be86-c8162a78d104";
    networking.hostName = "ax-vm"; # Define your hostname.

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
    ];

    services.xserver.desktopManager.xfce.enable = true;

    system.stateVersion = "25.05"; # Did you read the comment?
}
