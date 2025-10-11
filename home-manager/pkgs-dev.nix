{ pkgs, lib, config, ... }:

{
  options = {
    pkgsDev.enable = lib.mkEnableOption "Enable dev pkgs";
  };

  config = lib.mkIf config.pkgsDev.enable {
    home.packages = with pkgs; [
      # clojure-lsp # needed?
      babashka
      clojure
      gh
      jq
      leiningen
      rbenv
      ruby_3_4
      tokei
      vscodium
    ];
  };
}
