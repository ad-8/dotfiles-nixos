{ pkgs, lib, ... }:

{
  imports = [
    ./pkgs-core.nix
    ./pkgs-dev.nix
    ./pkgs-extra.nix
    ./pkgs-gui.nix
    ./pkgs-wm.nix
  ];

  pkgsCore.enable = lib.mkDefault true;
}

