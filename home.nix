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
    bat 
    emacs
	  ripgrep
    stow
    delta
    tokei
	  starship
    rbenv
    zoxide
    ncdu
    htop
    i3status-rust
    arandr
  ];

  # this overwrote the config in ~/dotfiles (make backup like we set it up though)
  # using existing config file for now 
  # programs.fish.enable = true;
}


