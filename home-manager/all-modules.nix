{ pkgs, lib, ... }:

{
  imports = [
    ./default-applications-mime.nix
    ./config-auth-agent.nix
    ./git.nix
    ./gtk.nix
    ./pkgs-core.nix
    ./pkgs-dev.nix
    ./pkgs-extra.nix
    ./pkgs-gui.nix
    ./pkgs-wm.nix
  ];

  pkgsCore.enable = lib.mkDefault true;
}

