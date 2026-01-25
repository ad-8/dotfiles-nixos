{ config, lib, pkgs, ... }:

{
  options = {
    configSuckless.enable = lib.mkEnableOption "dwm and co";
  };

  config = lib.mkIf config.configSuckless.enable {
    home.packages = with pkgs; [
      # https://www.tonybtw.com/tutorial/suckless-nixos/
      (pkgs.dwmblocks.overrideAttrs (_: {
        src = ../config/dwmblocks;
        patches = [ ];
      }))
      dmenu
      sxhkd
      xsct
    ];
  };
}
