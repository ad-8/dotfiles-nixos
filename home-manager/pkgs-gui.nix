{ pkgs, lib, config, ... }:

{
  options = {
    pkgsGui.enable = lib.mkEnableOption "Enable GUI pkgs";
  };

  config = lib.mkIf config.pkgsGui.enable {
    home.packages = with pkgs; [
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
      # picard
      qbittorrent
      xfce.mousepad
      xfce.ristretto
    ];
  };
}
