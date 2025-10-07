{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = "arthur";
        email = "arthurfleck8@proton.me";
      };
      init = {
        defaultBranch = "main";
      };
      # -------------------------------------------------------------------------------------------------------------------------
      # settings for [delta](https://github.com/dandavison/delta)
      core = {
        editor = "vim";
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;    # use n and N to move between diff sections
        light = false;      # set to true if you're in a terminal w/ a light background color 
        line-numbers = true;
        side-by-side = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
      # -------------------------------------------------------------------------------------------------------------------------
      credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      credential."https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
    };
  }; 
}
