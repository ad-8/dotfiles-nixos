{
  description = "nix develop .#suckless";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # run make in dwmblocks
    # after a nixos-rebuild new version is active
    # TODO -- https://www.tonybtw.com/tutorial/suckless-nixos/
    # puts it in main flake, so I think no manual make step there
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.suckless = pkgs.mkShell {
      # toolchain + headers/libs
      packages = with pkgs; [
        pkg-config
        xorg.libX11
        xorg.libXft
        xorg.libXinerama
        fontconfig
        freetype
        harfbuzz
        gcc
        gnumake
      ];
    };
  };
}
