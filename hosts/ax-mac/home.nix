{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/pkgs-bundle.nix
  ];

  # https://github.com/vimjoyer/modularize-video (as seen in https://www.youtube.com/watch?v=vYc6IzKvAJQ)
  # pkgsCore.enable = true; # enabled by default, see pkgs-bundle.nix
  pkgsDev.enable = true;
  pkgsExtra.enable = true;
  pkgsGui.enable = true;
  pkgsWm.enable = true;

  defaultApplicationsMime.enable = true;
  configGit.enable = true;
  configGtk.enable = true;

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

    # printing
    hplip
    system-config-printer
    # other
    chezmoi
    gcr # Provides org.gnome.keyring.SystemPrompter
    libqalculate # provides qalc for rofi-calc
    multimarkdown # to enable markdown-preview in doom emacs
  ];

  programs.bash = {
	  enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };

  # https://wiki.nixos.org/wiki/Polkit
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # https://wiki.nixos.org/wiki/Secret_Service
  services.gnome-keyring.enable = true;

  # this overwrote the config in ~/dotfiles (made backup like we set it up though)
  # -> using existing config file for now 
  # programs.fish.enable = true;
}

