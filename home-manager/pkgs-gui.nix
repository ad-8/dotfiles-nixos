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
      kdePackages.okular
      keepassxc
      libreoffice-still
      localsend
      # megasync # this compiles from src! TODO broken after upgrading to 25.11 (won't build)
      mpv
      pavucontrol
      picard
      qalculate-gtk
      qbittorrent
      strawberry
      thunderbird
      ungoogled-chromium
      vlc
      xfce.mousepad
      xfce.ristretto
    ];
  };
}
