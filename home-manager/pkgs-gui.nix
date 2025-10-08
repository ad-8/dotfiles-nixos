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
    pavucontrol
    picard
    qbittorrent
    xfce.mousepad
    xfce.ristretto
  ];
}
