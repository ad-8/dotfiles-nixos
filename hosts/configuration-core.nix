{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Configure console keymap
  console.keyMap = "de";
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ax = {
    isNormalUser = true;
    description = "ax";
    extraGroups = [ "libvirtd" "networkmanager" "video" "wheel" ];
    packages = with pkgs; [
      git
      vim
    ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # display manager, window manager and shell
  services.xserver.displayManager.gdm.enable = true;
  programs.sway.enable = true; # needed a reboot to show up in the display manager
  programs.fish.enable = true;
  users.users.ax.shell = pkgs.fish;

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=30
  '';

  # Some programs are installed like this, don't know why yet
  programs.firefox.enable = true;
  programs.java.enable = true;
  # https://wiki.nixos.org/wiki/Thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
