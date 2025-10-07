{ pkgs, ... }:

{
  ps = with pkgs; [
    brave
    gimp3
    libreoffice-still
    kdePackages.dolphin
    kdePackages.okular
  ];
}
