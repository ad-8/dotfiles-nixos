{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];


    boot.initrd.luks.devices."luks-2fc19056-a600-4e50-8de6-47b442b623c9".device = "/dev/disk/by-uuid/2fc19056-a600-4e50-8de6-47b442b623c9";
    networking.hostName = "ax-fuji";


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
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 2283 9090 9091 ];
    # networking.firewall.allowedUDPPorts = [ ... ];


    environment.systemPackages = with pkgs; [
      htop
      podman-compose
      wget
      vlock
      gh
      fastfetch
      delta
      tokei
      shiori # TODO evaluate (pocket/read-it-later replacement)
      tmux
      starship
      zoxide
      nnn
      ncdu
      fd
      stow
    ];


    system.stateVersion = "25.05"; # Did you read the comment?
}
