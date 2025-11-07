{ pkgs, lib, config, ... }:

{
  options = {
    pkgsExtra.enable = lib.mkEnableOption "Enable extra pkgs";
  };

  config = lib.mkIf config.pkgsExtra.enable {
    home.packages = with pkgs; [
      bluetui
      chezmoi
      imagemagick
      inxi # Full featured CLI system information tool
      libqalculate # provides qalc for rofi-calc
      lm_sensors # provides `sensors` cmd to show cpu temp etc.
      multimarkdown # to enable markdown-preview in doom emacs
      nh
      pciutils # lspci and more
      pdftk
      smartmontools
      steam-run
      unzip # no zip, use tar xD
      usbutils # lsusb and more

      # emacs dirvish
      ffmpegthumbnailer
      mediainfo
      poppler-utils # contains pdftoppm, needed by emacs dirvish
      vips

      # screenshot setup
      grim
      slurp
      swappy
    ];
  };
}

