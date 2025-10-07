{ pkgs, ... }:

{
  ps = with pkgs; [
    # clojure-lsp # needed?
    babashka
    clojure
    delta
    gh
    leiningen
    rbenv
    tokei
    vscodium
  ];
}
