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
      rbenv
      ruby_3_4
      vscodium
      neovim
      lazygit
      semgrep # needed for clojure lsp and others in emacs
    ];
  };
}
