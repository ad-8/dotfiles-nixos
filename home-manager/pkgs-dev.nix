{ pkgs, lib, config, ... }:

{
  options = {
    pkgsDev.enable = lib.mkEnableOption "Enable dev pkgs";
  };

  config = lib.mkIf config.pkgsDev.enable {
    home.packages = with pkgs; [
      babashka
      bundix
      clojure
      clojure-lsp
      gh
      jetbrains.ruby-mine
      jq
      leiningen
      ruby_3_4
      vscodium
      semgrep # needed for clojure lsp and others in emacs
    ];
  };
}
