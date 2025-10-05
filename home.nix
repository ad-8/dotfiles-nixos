{ config, pkgs, ... }:

{
  home.username = "ax";
  home.homeDirectory = "/home/ax";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
	enable = true;
        shellAliases = {
          btw = "echo Keira is so fucking hot! Sydney too :D";
        };
  };

#  home.file.".config/qtile".source = ./config/qtile;

  home.packages = with pkgs; [
	ripgrep
        stow
        fish
        delta
  ];
}


