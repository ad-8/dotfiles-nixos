{ config, lib, pkgs, ... }:

{
  imports = [
    ./configuration-extra.nix
    ./configuration-printing.nix
  ];
}
