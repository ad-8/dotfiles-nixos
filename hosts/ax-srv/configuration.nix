{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];


    boot.initrd.luks.devices."luks-2fc19056-a600-4e50-8de6-47b442b623c9".device = "/dev/disk/by-uuid/2fc19056-a600-4e50-8de6-47b442b623c9";
    networking.hostName = "ax-fuji";


    boot.supportedFilesystems = [ "nfs" ]; # installs NFS utilities for the client
 
    services.openssh = {
      enable = true;
    };

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };


    # The firewall is enabled by default on NixOS. Still, explicitly ensure it is enabled
    networking.firewall.enable = true;
    # Open ports in the firewall: [immich, linkding, shiori]
    networking.firewall.allowedTCPPorts = [ 2283 9090 9091 ];
    # networking.firewall.allowedUDPPorts = [ ... ];


    environment.systemPackages = with pkgs; [
      emacs
      vlock

      # tools
      delta
      eza
      fastfetch
      fd
      fzf
      gh
      htop
      ncdu
      nnn
      ripgrep
      starship
      stow
      tmux
      tokei
      wget
      zoxide

      restic

      # code
      babashka
      ruby_3_4
      
      # selfhosting
      podman-compose
      shiori # TODO evaluate (pocket/read-it-later replacement)
    ];


    # TODO why bother with separating pkgs?
    users.users.ax = {
      packages = with pkgs; [
      ];
    };


    system.stateVersion = "25.05"; # Did you read the comment?
}
