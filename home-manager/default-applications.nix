{ config, lib, pkgs, ... }:

# https://wiki.nixos.org/wiki/Default_applications
# 
# To list all .desktop-files, run
# ls /run/current-system/sw/share/applications # for global packages
# ls /etc/profiles/per-user/$(id -n -u)/share/applications # for user packages
# ls ~/.nix-profile/share/applications # for home-manager packages
let
  browser = [ "firefox.desktop" ];
  emacs = [ "emacs.desktop" ];
  imageViewer = [ "org.kde.gwenview.desktop" ];
  pdfReader = [ "org.kde.okular.desktop" ];
  simpleTextEditor = [ "org.xfce.mousepad.desktop" ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # HTML-files and URLs
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
      # Images
      "image/gif" = imageViewer;
      "image/jpeg" = imageViewer;
      "image/jpg" = imageViewer;
      "image/png" = imageViewer;
      "image/webp" = imageViewer;
      "image/*" = imageViewer;
      # Documents
      "application/pdf" = pdfReader;
      "text/plain" = simpleTextEditor;
      "text/markdown" = emacs;
      "text/org" = emacs;
      "text/*" = simpleTextEditor;
    };
  };
}
