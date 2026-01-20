{ config, lib, pkgs, ... }:

{
  imports =
    [ 
    ./hardware-configuration.nix
    ../configuration-core.nix
    ];


    boot.initrd.luks.devices."luks-2fc19056-a600-4e50-8de6-47b442b623c9".device = "/dev/disk/by-uuid/2fc19056-a600-4e50-8de6-47b442b623c9";
    boot.supportedFilesystems = [ "nfs" ]; # installs NFS utilities for the client
    networking.hostName = "ax-fuji";


    environment.systemPackages = with pkgs; [
      emacs
      vlock

      # cli tools
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

      # backup
      restic
      rclone

      # code
      babashka
      ruby_3_4

      # selfhosting
      podman-compose
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];


    # TODO why bother with separating pkgs?
    users.users.ax = {
      packages = with pkgs; [
      ];
    };


    networking.firewall.enable = true; # enabled by default, still enable explicitly
    networking.firewall.allowedTCPPorts = [ 2283 9090 ]; # immich, linkding
    # networking.firewall.allowedUDPPorts = [ ... ];


    services = {
      cron = {
        enable = true;
        systemCronJobs = [
          "10 3 * * *     ax     . /etc/profile; ruby $HOME/x/backup/ax-srv-backup-immich.rb >> ~/cron-immich.log 2>&1"
          "20 3 * * *     ax     . /etc/profile; ruby $HOME/x/backup/ax-srv-backup-linkding.rb >> ~/cron-linkding.log 2>&1"
          # download daily wallpaper
          "0 9,10,11 * * *     ax     . /etc/profile; nix develop ~/x --command ruby ~/x/bing_wallpaper_dl.rb >> ~/bing.log 2>&1"
        ];
      };
      jellyfin = {
        enable = true;
        openFirewall = true;
        user = "ax";
      };
      openssh = {
        enable = true;
      };
      syncthing = {
        enable = true;
        openDefaultPorts = true;
        group = "users";
        user = "ax";
        dataDir = "/home/ax/syncthing"; # Default folder for new synced folders
        configDir = "/home/ax/.config/syncthing"; # Folder for Syncthing's settings and keys
      };
    };


    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
      };
    };


    system.stateVersion = "25.05"; # Did you read the comment?
}
