{
  description = "foo";

  inputs = {
	  nixpkgs-stable.url = "nixpkgs/nixos-25.11";
	  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	  home-manager-stable = { url = "github:nix-community/home-manager/release-25.11"; inputs.nixpkgs.follows = "nixpkgs-stable"; };
	  home-manager-unstable = { url = "github:nix-community/home-manager/master"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs-unstable { inherit system; };
    mkConfig = { hostname, username ? "ax", nixpkgs ? nixpkgs-stable , home-manager ? home-manager-stable}:
    let
      hm = if home-manager != null then [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./hosts/${hostname}/home.nix;
            backupFileExtension = "backup";
          };
        }
      ] else [];
    in
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${hostname}/configuration.nix
      ] ++ hm;
    };
  in {
    devShells.${system}.suckless = pkgs.mkShell {
      # a devshell for suckless tools like dwm, dmenu or st (toolchain + headers/libs)
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
    nixosConfigurations = {
      ax-mac = mkConfig { hostname = "ax-mac"; };
      ax-x1c = mkConfig { hostname = "ax-x1c"; };
      ax-bee = mkConfig { hostname = "ax-bee"; };
      ax-vm = mkConfig { hostname = "ax-vm"; };
      ax-fuji = mkConfig { hostname = "ax-fuji"; home-manager = null; };
    };
  };
}
