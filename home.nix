{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  home.packages = with pkgs; [
    # rofi 2.0 (which has wayland support) not in 25.05 repo
    alacritty
    arandr
    bat 
    delta
    emacs
    eza
    fastfetch
    fd
    fzf
    gh
    htop
    i3status-rust
    ncdu
    nnn
    rbenv
    ripgrep
    rofi-wayland
    starship
    stow
    tokei
    waybar
    zoxide
  ];

  programs.bash = {
	  enable = true;
    shellAliases = {
      btw = "echo 'home-manager seems to be working :)'";
    };
  };
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "arthur";
        email = "arthurfleck8@proton.me";
      };
      init = {
        defaultBranch = "main";
      };
      # -------------------------------------------------------------------------------------------------------------------------
      # settings for [delta](https://github.com/dandavison/delta)
      core = {
        editor = "vim";
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;    # use n and N to move between diff sections
        light = false;      # set to true if you're in a terminal w/ a light background color 
        line-numbers = true;
        side-by-side = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      # -------------------------------------------------------------------------------------------------------------------------
      credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
    };
  }; 

  # this overwrote the config in ~/dotfiles (made backup like we set it up though)
  # -> using existing config file for now 
  # programs.fish.enable = true;
}

