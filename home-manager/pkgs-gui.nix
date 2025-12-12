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
      ungoogled-chromium
      xfce.ristretto

      # TODO broken after upgrading to 25.11
      # (probably because pkg `python313Packages.protonvpn-nm-lib` is in 25.05, but missing in 25.11;
      # removed this nm pkg from there when upgrading macbook to 25.11)
      # protonvpn-gui
      # python313Packages.proton-keyring-linux # ProtonVPN core component to access Linux's keyring
      # python313Packages.proton-vpn-network-manager # Provides the necessary functionality for other ProtonVPN components to interact with NetworkManager
    ];
  };
}
