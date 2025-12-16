{ config, lib, pkgs, ... }:

{
  options = {
    configExtra.enable = lib.mkEnableOption "Enable extra config";
  };

  config = lib.mkIf config.configExtra.enable {

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
    services.xserver.enable = true; # Enable the X11 windowing system.
    systemd.services.display-manager.enable = false; # NixOS defaults to LightDM when no display-manager is explicitly enabled
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
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    environment.systemPackages = with pkgs; [
      clamav
      ffmpeg-full
      restic
      rclone
    ];

    services.clamav.daemon.enable = true;
    services.clamav.updater.enable = true;

    # TODO failed to start the daemon after nixos-rebuild
    # services.emacs.enable = true;

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

      # The firewall is enabled by default on NixOS. Still, explicitly ensure it is enabled
      networking.firewall.enable = true;
      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
  };
}

