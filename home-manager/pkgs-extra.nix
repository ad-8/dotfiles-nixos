{ pkgs, ... }:

{
  ps = with pkgs; [
    imagemagick
    pdftk
    picard
    smartmontools
  ];
}
