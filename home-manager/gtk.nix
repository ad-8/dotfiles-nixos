{ pkgs, lib, config, ... }:

{
  options = {
    configGtk.enable = lib.mkEnableOption "Enable GTK config";
  };

  config = lib.mkIf config.configGtk.enable {
    # https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/
    gtk = {
      enable = true;
      # works -> see e.g. thunar
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      # works -> see e.g. nm-applet tray icon
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      # works -> set in sway config and .Xresources (for xwayland)
      cursorTheme = {
        name = "Numix-Cursor";
        package = pkgs.numix-cursor-theme;
      };
    };
  };
}

