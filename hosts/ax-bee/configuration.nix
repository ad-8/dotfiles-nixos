# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../configuration-core.nix
    ../configuration-extra.nix
    ];


    boot.initrd.luks.devices."luks-1101d87b-2380-4455-a516-1dda026f32e3".device = "/dev/disk/by-uuid/1101d87b-2380-4455-a516-1dda026f32e3";
    networking.hostName = "ax-bee"; # Define your hostname.


    services.desktopManager.plasma6.enable = true;

    services.keyd = {
      enable = true;
      keyboards = {
        # The name is just the name of the configuration file, it does not really matter
        default = {
          ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
          # Everything but the ID section:
          settings = {
            # The main layer, if you choose to declare it in Nix
            main = {
              #capslock = "layer(control)"; # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
              leftalt = "leftmeta";
              leftmeta = "leftalt";
            };
            otherlayer = {};
          };
          extraConfig = ''
            # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
          '';
        };
      };
    };


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
}

