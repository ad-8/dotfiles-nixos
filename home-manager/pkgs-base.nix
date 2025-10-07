{ pkgs, ... }:

{
  ps = with pkgs; [
    alacritty
    bat 
    emacs
    eza
    fastfetch
    fd
    file
    fzf
    htop
    ncdu
    nnn
    psmisc # provides killall
    ripgrep
    starship
    stow
    tealdeer
    tree
    zoxide
  ];
}
