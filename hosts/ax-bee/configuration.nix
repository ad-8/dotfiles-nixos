# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.initrd.luks.devices."luks-1101d87b-2380-4455-a516-1dda026f32e3".device = "/dev/disk/by-uuid/1101d87b-2380-4455-a516-1dda026f32e3";

    networking.hostName = "ax-bee"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;


    security.polkit.enable = true;
    # Auto-decrypt keyring on login (The NixOS module for GNOME Keyring enables its PAM module automatically
    # via security.pam.services.*.enableGnomeKeyring, however the Home Manager module does not), so:
    #
    # works with GDM, but sadly not (yet?) with ly
    security.pam.services.login.enableGnomeKeyring = true;

    # systemd services
    # check like on regular distro: systemctl status spice-vdagentd
    #services.spice-vdagentd.enable = true;

    services.desktopManager.plasma6.enable = true;

    # https://wiki.nixos.org/wiki/Backlight
    hardware.i2c.enable = true;
    # thanks https://mynixos.com/nixpkgs/option/programs.light.enable
    programs.light.enable = true;

    # https://wiki.nixos.org/wiki/Syncthing
    services = {
      syncthing = {
        enable = true;
        openDefaultPorts = true;
        group = "users";
        user = "ax";
        dataDir = "/home/ax/syncthing"; # Default folder for new synced folders
        configDir = "/home/ax/.config/syncthing"; # Folder for Syncthing's settings and keys
      };
    };

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


    # Enable CUPS to print documents.
    services.printing.enable = true;

    hardware.bluetooth.enable = true;
    services.blueman.enable = true; # provides blueman-applet and blueman-manager

    # laptop battery info via `upower --dump`
    services.upower.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.05"; # Did you read the comment?
}
