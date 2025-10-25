{ pkgs, lib, config, ... }:

{
  options = {
    pkgsDev.enable = lib.mkEnableOption "Enable dev pkgs";
  };

  config = lib.mkIf config.pkgsDev.enable {
    home.packages = with pkgs; [
      # clojure-lsp # needed?
      babashka
      bundix
      clojure
      gh
      jetbrains.ruby-mine
      jq
      leiningen
      rbenv
      ruby_3_4
      vscodium
      neovim
      lazygit
    ];
  };
}
