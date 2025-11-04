{ pkgs, lib, config, ... }:

{
  options = {
    pkgsExtra.enable = lib.mkEnableOption "Enable extra pkgs";
  };

  config = lib.mkIf config.pkgsExtra.enable {
    home.packages = with pkgs; [
      chezmoi
      imagemagick
      inxi # Full featured CLI system information tool
      libqalculate # provides qalc for rofi-calc
      lm_sensors # provides `sensors` cmd to show cpu temp etc.
      multimarkdown # to enable markdown-preview in doom emacs
      pciutils # lspci and more
      pdftk
      poppler-utils # contains pdftoppm, needed by emacs dirvish
      smartmontools
      steam-run
      unzip # no zip, use tar xD
      usbutils # lsusb and more
      vips # fast image processing library, used e.g. in emacs dirvish
    ];
  };
}

