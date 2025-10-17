{ pkgs, lib, config, ... }:

{
  options = {
    pkgsGui.enable = lib.mkEnableOption "Enable GUI pkgs";
  };

  config = lib.mkIf config.pkgsGui.enable {
    home.packages = with pkgs; [
      anki
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
      strawberry
      xfce.mousepad
      xfce.ristretto
    ];
  };
}
