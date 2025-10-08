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
    ruby_3_4
    tokei
    vscodium
  ];
}
