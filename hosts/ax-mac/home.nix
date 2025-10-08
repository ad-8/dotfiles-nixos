{ config, pkgs, ... }:

let
  pkgs_base = import ../../home-manager/pkgs-base.nix { inherit pkgs; };
  pkgs_gui = import ../../home-manager/pkgs-gui.nix { inherit pkgs; };
  pkgs_dev = import ../../home-manager/pkgs-dev.nix { inherit pkgs; };
  pkgs_wm = import ../../home-manager/pkgs-wm.nix { inherit pkgs; };
in
{

  imports = [
    ../../home-manager/git.nix
    ../../home-manager/gtk.nix
  ];

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
    gcr # Provides org.gnome.keyring.SystemPrompter
    libqalculate # provides qalc for rofi-calc
    multimarkdown # to enable markdown-preview in doom emacs
  ] ++ pkgs_base.ps ++ pkgs_gui.ps ++ pkgs_dev.ps ++ pkgs_wm.ps;

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

