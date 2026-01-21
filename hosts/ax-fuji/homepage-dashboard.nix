{ config, lib, pkgs, ... }:

{
  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
    environmentFile = "/home/ax/dotfiles-nixos/hosts/ax-fuji/.env"; # must contain HOMEPAGE_ALLOWED_HOSTS
    settings = {
      statusStyle = "dot";
    };
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
    services = [
      {
        "Media" = [
          {
            Immich = {
              href = "http://192.168.178.8:2283";
              icon = "immich.png";
              description = "Photos";
              siteMonitor = "http://192.168.178.8:2283";
            };
          }
          {
            Jellyfin = {
              href = "http://192.168.178.8:8096";
              icon = "jellyfin.png";
              description = "Media Server";
              siteMonitor = "http://192.168.178.8:8096";
            };
          }
        ];
      }
      {
        "Misc" = [
          {
            Linkding = {
              href = "http://192.168.178.8:9090";
              icon = "linkding.png";
              description = "Bookmarks";
              siteMonitor = "http://192.168.178.8:9090";
            };
          }
        ];
      }
    ];

  };
}
