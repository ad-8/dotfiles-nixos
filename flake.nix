{
  description = "foo";

  inputs = {
	  nixpkgs-stable.url = "nixpkgs/nixos-25.05";
	  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	  home-manager-stable = { url = "github:nix-community/home-manager/release-25.05"; inputs.nixpkgs.follows = "nixpkgs-stable"; };
	  home-manager-unstable = { url = "github:nix-community/home-manager/master"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, ... }:
  let
    system = "x86_64-linux";
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
    nixosConfigurations = {
      ax-mac = mkConfig { hostname = "ax-mac"; };
      ax-bee = mkConfig { hostname = "ax-bee"; };
      ax-vm = mkConfig { hostname = "ax-vm"; };
      ax-srv = mkConfig { hostname = "ax-srv"; home-manager = null; };
    };
  };
}
