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


    environment.systemPackages = with pkgs; [
    ];


    system.stateVersion = "25.05"; # Did you read the comment?
}
