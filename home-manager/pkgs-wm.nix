{ pkgs, lib, config, ... }:

{
  options = {
    pkgsWm.enable = lib.mkEnableOption "Enable WM pkgs";
  };

  config = lib.mkIf config.pkgsWm.enable {
    home.packages = with pkgs; [
      # light # enabled in configuration.nix
      ddcutil
      dunst
      gammastep
      hypridle
      libnotify
      networkmanagerapplet
      playerctl
      rofi
      sct
      swaybg
      swaylock
      waybar
      wl-clipboard
      wmenu

      # xorg
      dmenu
      sxhkd
      xsct
    ];
  };
}
