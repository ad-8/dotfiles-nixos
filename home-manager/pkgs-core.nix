{ pkgs, lib, config, ... }:

{
  options = {
    pkgsCore.enable = lib.mkEnableOption "Enable core pkgs";
  };

  config = lib.mkIf config.pkgsCore.enable {
    home.packages = with pkgs; [
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
      wget
      zoxide
    ];
  };
}
