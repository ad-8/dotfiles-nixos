{ pkgs, ... }:

{
  ps = with pkgs; [
    # light # enabled in configuration.nix
    # rofi 2.0 (which has wayland support) not in 25.05 repo
    ddcutil
    dunst
    gammastep
    libnotify
    networkmanagerapplet
    rofi-calc
    rofi-wayland
    sct
    waybar
    wmenu
  ];
}
