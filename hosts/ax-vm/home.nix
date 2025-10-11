{ config, pkgs, ... }:

{
  imports = [
    ../../home-manager/all-modules.nix
  ];

  # pkgsCore.enable = true; # enabled by default, see pkgs-bundle.nix
  pkgsDev.enable = false;
  pkgsExtra.enable = false;
  pkgsGui.enable = false;
  pkgsWm.enable = true;

  defaultApplicationsMime.enable = true;
  configGit.enable = true;
  configGtk.enable = true;

  home.stateVersion = "25.05";
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  home.packages = with pkgs; [
    # other
    gcr # Provides org.gnome.keyring.SystemPrompter
    libqalculate # provides qalc for rofi-calc
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

