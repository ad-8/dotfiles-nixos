{ config, lib, pkgs, ... }:

{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    environmentFile = "/home/ax/dotfiles-nixos/hosts/ax-fuji/.env"; # must contain HOMEPAGE_ALLOWED_HOSTS
    widgets = [
      {
        datetime = {
          locale = "de-DE";
          text_size = "xl";
          format = {
            hourCycle = "h23";
            dateStyle= "full";
            timeStyle = "medium";
          };
        };
      }
      {
        resources = {
          label = "uptime";
          uptime = true;
        };
      }
      {
        resources = {
          label = "system resources";
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
    ];
    services = {

    };
  };
}
