{ pkgs, lib, config, ... }:

{
  options = {
    pkgsDev.enable = lib.mkEnableOption "Enable dev pkgs";
  };

  config = lib.mkIf config.pkgsDev.enable {
    home.packages = with pkgs; [
      bundix
      clojure
      clojure-lsp
      gh
      jetbrains.ruby-mine
      jq
      leiningen
      rubyPackages_3_4.solargraph
      semgrep # needed for clojure lsp and others in emacs
      vscodium
    ];
  };
}
