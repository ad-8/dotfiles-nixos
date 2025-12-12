{ pkgs, lib, config, ... }:

{
  options = {
    pkgsWm.enable = lib.mkEnableOption "Enable WM pkgs";
  };

  config = lib.mkIf config.pkgsWm.enable {
    home.packages = with pkgs; [
      # programs.sway.enable installs swaylock, swayidle
      # 
      # light # enabled in configuration.nix
      ddcutil
      dunst
      gammastep
      libnotify
      networkmanagerapplet
      playerctl
      rofi
      sct
      swaybg
      waybar
      wl-clipboard
      wmenu
    ];
  };
}
