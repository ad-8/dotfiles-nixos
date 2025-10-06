{ config, pkgs, ... }:

{
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
	  enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };

  #  home.file.".config/qtile".source = ./config/qtile;

  home.packages = with pkgs; [
    arandr
    bat 
    delta
    emacs
    eza
    htop
    i3status-rust
    ncdu
    rbenv
    ripgrep
    starship
    stow
    tokei
    zoxide
  ];

  # this overwrote the config in ~/dotfiles (make backup like we set it up though)
  # using existing config file for now 
  # programs.fish.enable = true;
}


