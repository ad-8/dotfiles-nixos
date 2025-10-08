{ pkgs, ... }:

{
  ps = with pkgs; [
    brave
    gimp3
    gnome-disk-utility
    kdePackages.dolphin
    kdePackages.gwenview
    kdePackages.okular
    keepassxc
    libreoffice-still
    mpv
    qbittorrent
    xfce.mousepad
  ];
}
