{ pkgs, lib, config, ... }:

{
  options = {
    pkgsExtra.enable = lib.mkEnableOption "Enable extra pkgs";
  };

  config = lib.mkIf config.pkgsExtra.enable {
    home.packages = with pkgs; [
      gcr # Provides org.gnome.keyring.SystemPrompter
      imagemagick
      libqalculate # provides qalc for rofi-calc
      lm_sensors # provides sensors to show cpu temp etc.
      pdftk
      smartmontools
      unzip # no zip, use tar xD
    ];
  };
}

