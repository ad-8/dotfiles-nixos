{ pkgs, lib, ... }:

{
  imports = [
    ./config-auth-agent.nix
    ./config-default-applications-mime.nix
    ./config-git.nix
    ./config-gtk.nix
    ./config-secret-service.nix
    ./pkgs-core.nix
    ./pkgs-dev.nix
    ./pkgs-extra.nix
    ./pkgs-gui.nix
    ./pkgs-wm.nix
  ];

  pkgsCore.enable = lib.mkDefault true;
}

