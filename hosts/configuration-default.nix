{ config, lib, pkgs, ... }:

{
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";


  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # window manager related stuff
  services.displayManager.ly.enable = true;
  programs.sway.enable = true; # needed a reboot to show up in display manager

  programs.fish.enable = true;
  users.users.ax.shell = pkgs.fish;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ax = {
    isNormalUser = true;
    description = "ax";
    extraGroups = [ "networkmanager" "video" "wheel" ];
    packages = with pkgs; [
      git
      vim
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install firefox.
  programs.firefox.enable = true;
  programs.java.enable = true;

  # thunar via https://wiki.nixos.org/wiki/Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
