{ config, pkgs, ... }:

{

  imports = [
    ../../home-manager/git.nix
    ../../home-manager/gtk.nix
  ];

  home.stateVersion = "25.05";
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  home.packages = with pkgs; [
    # rofi 2.0 (which has wayland support) not in 25.05 repo
    alacritty
    bat 
    delta
    emacs
    eza
    fastfetch
    fd
    fzf
    gh
    htop
    ncdu
    nnn
    rbenv
    ripgrep
    starship
    stow
    tokei
    waybar
    zoxide

    # gui
    brave
    gimp3
    libreoffice-still
    vscodium
    kdePackages.dolphin
    kdePackages.okular

    # legacy
    arandr
    i3status-rust

    # other
    libqalculate # provides qalc for rofi-calc
    tealdeer

    # essentials
    file
    psmisc # provides killall
    tree

    # coding
    babashka
    clojure
    leiningen
    # clojure-lsp # needed?


    # window manager tools
    # light # enabled in configuration.nix
    ddcutil
    dunst
    gammastep
    libnotify
    rofi-calc
    rofi-wayland
    sct
    wmenu
  ];

  programs.bash = {
	  enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };

  # this overwrote the config in ~/dotfiles (made backup like we set it up though)
  # -> using existing config file for now 
  # programs.fish.enable = true;
}

