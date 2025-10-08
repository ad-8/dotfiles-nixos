{ pkgs, ... }:

{
  ps = with pkgs; [
    # clojure-lsp # needed?
    babashka
    clojure
    delta
    gh
    jq
    leiningen
    rbenv
    ruby_3_4
    tokei
    vscodium
  ];
}
