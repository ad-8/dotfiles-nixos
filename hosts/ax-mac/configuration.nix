# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../configuration-core.nix
    ../ax-configs.nix
    ];

    configExtra.enable = true;
    configPrinting.enable = true;


    boot.initrd.luks.devices."luks-f43e8971-1fb7-4d8c-be86-c8162a78d104".device = "/dev/disk/by-uuid/f43e8971-1fb7-4d8c-be86-c8162a78d104";
    networking.hostName = "ax-mac"; # Define your hostname.

    # ignore short presses of the power button entirely. Long-pressing your power button (5 seconds or longer)
    # to do a hard reset is handled by your machine’s BIOS/EFI and thus still possible.
    # (https://wiki.nixos.org/wiki/Systemd/logind)
    services.logind.powerKey = "ignore"; # started working after a reboot

    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              # Maps capslock to escape when pressed and control when held.
              capslock = "overload(control, esc)";
              # Remaps the escape key to capslock
              # esc = "capslock";
            };
          };
        };
      };
    };

    # laptop battery info via `upower --dump`
    services.upower.enable = true;


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}

