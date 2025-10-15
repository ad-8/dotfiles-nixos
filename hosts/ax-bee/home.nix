{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/all-modules.nix
  ];

  # https://github.com/vimjoyer/modularize-video (as seen in https://www.youtube.com/watch?v=vYc6IzKvAJQ)
  # pkgsCore.enable = true; # enabled by default, see all-modules.nix
  pkgsDev.enable = true;
  pkgsExtra.enable = true;
  pkgsGui.enable = true;
  pkgsWm.enable = true;

  defaultApplicationsMime.enable = true;
  configAuthAgent.enable = true;
  configSecretService.enable = true;
  configGit.enable = true;
  configGtk.enable = true;
  configQt.enable = true;

  home.stateVersion = "25.05";
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  home.packages = with pkgs; [
    # TODO proton vpn setup
    # protonvpn-cli # sadly, does not let me log in (API error)
    # and gui doesn't remember credentials after logout/login (works after reboot again), even with those 3 pkgs below 
    protonvpn-gui
    python313Packages.protonvpn-nm-lib # ProtonVPN NetworkManager Library intended for every ProtonVPN service user
    python313Packages.proton-keyring-linux # ProtonVPN core component to access Linux's keyring
    python313Packages.proton-vpn-network-manager # Provides the necessary functionality for other ProtonVPN components to interact with NetworkManager

    # other
    chezmoi
    libqalculate # provides qalc for rofi-calc
    multimarkdown # to enable markdown-preview in doom emacs

    fooyin
    jetbrains.ruby-mine
  ];

  programs.bash = {
	  enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };
}

