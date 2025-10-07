{ pkgs, ... }:

{
  ps = with pkgs; [
    brave
    gimp3
    gnome-disk-utility
    kdePackages.dolphin
    kdePackages.okular
    keepassxc
    libreoffice-still
    mpv
    qbittorrent
  ];
}
