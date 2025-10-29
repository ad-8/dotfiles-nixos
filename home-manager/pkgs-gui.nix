{ pkgs, lib, config, ... }:

{
  options = {
    pkgsGui.enable = lib.mkEnableOption "Enable GUI pkgs";
  };

  config = lib.mkIf config.pkgsGui.enable {
    home.packages = with pkgs; [
      anki
      brave
      fooyin
      gimp3
      gnome-disk-utility
      kdePackages.dolphin
      kdePackages.gwenview
      kdePackages.okular
      keepassxc
      libreoffice-still
      # megasync # this compiles from src!
      mpv
      pavucontrol
      picard
      qalculate-gtk
      qbittorrent
      strawberry
      ungoogled-chromium
      xfce.mousepad
      xfce.ristretto

      # TODO proton vpn setup
      # protonvpn-cli # sadly, does not let me log in (API error)
      # and gui doesn't remember credentials after logout/login (works after reboot again), even with those 3 pkgs below 
      protonvpn-gui
      python313Packages.protonvpn-nm-lib # ProtonVPN NetworkManager Library intended for every ProtonVPN service user
      python313Packages.proton-keyring-linux # ProtonVPN core component to access Linux's keyring
      python313Packages.proton-vpn-network-manager # Provides the necessary functionality for other ProtonVPN components to interact with NetworkManager
    ];
  };
}
