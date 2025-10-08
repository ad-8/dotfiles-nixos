{ pkgs, ... }:

{
  ps = with pkgs; [
    imagemagick
    pdftk
    smartmontools
  ];
}
