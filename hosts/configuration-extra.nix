{ config, lib, pkgs, ... }:

{
  options = {
    configExtra.enable = lib.mkEnableOption "Enable extra config";
  };

  config = lib.mkIf config.configExtra.enable {
    networking.networkmanager.enable = true;

    security.polkit.enable = true;
    # Auto-decrypt keyring on login (The NixOS module for GNOME Keyring enables its PAM module automatically
    # via security.pam.services.*.enableGnomeKeyring, however the Home Manager module does not), so:
    #
    # works with GDM, but sadly not (yet?) with ly
    security.pam.services.login.enableGnomeKeyring = true;

    # https://wiki.nixos.org/wiki/Backlight
    hardware.i2c.enable = true;
    # thanks https://mynixos.com/nixpkgs/option/programs.light.enable
    programs.light.enable = true;

    # ensure the client has the necessary NFS utilities installed
    boot.supportedFilesystems = [ "nfs" ];

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


    # TODO put settings in the following sections in config-<category>.nix files
    # -------------------------------------
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    # systemd.services.display-manager.enable = false; # disables all display managers. NixOS defaults to LightDM when no display-manager is explicitly enabled
    programs.hyprland = {
      enable = true;
      withUWSM = false; # recommended for most users -- not working for me on 25.11
      xwayland.enable = true;
    };
    # -------------------------------------
    programs.firefox.enable = true;
    programs.java.enable = true;
    # https://wiki.nixos.org/wiki/Thunar
    programs.thunar.enable = true;
    programs.xfconf.enable = true;
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
    # -------------------------------------
    fonts.packages = with pkgs; [
      nerd-fonts.hack
    ];
    # -------------------------------------


    hardware.bluetooth.enable = true;
    services.blueman.enable = true; # provides blueman-applet and blueman-manager

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };


    environment.systemPackages = with pkgs; [
      clamav
      ffmpeg-full
      restic
      rclone
    ];


    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;


    # The firewall is enabled by default on NixOS. Still, explicitly ensure it is enabled
    networking.firewall.enable = true;
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
  };
}

