{ pkgs, ... }:

{
  ps = with pkgs; [
    imagemagick
    pdftk
    smartmontools
    unzip # no zip, use tar xD
  ];
}
