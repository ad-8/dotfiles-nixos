{
  description = "foo";

  inputs = {
	  nixpkgs-stable.url = "nixpkgs/nixos-25.05";
	  nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
	  home-manager-stable = {
		  url = "github:nix-community/home-manager/release-25.05";
		  inputs.nixpkgs.follows = "nixpkgs-stable";
	  };
	  home-manager-unstable = {
		  url = "github:nix-community/home-manager/master";
		  inputs.nixpkgs.follows = "nixpkgs-unstable";
	  };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, ... }:
  let
    system = "x86_64-linux";
    mkConfig = { hostname, username, nixpkgs, home-manager }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${hostname}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./hosts/${hostname}/home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
    };
    # TODO refactor mkConfig: make home-manager optional
    mkConfigServer = { hostname, nixpkgs }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${hostname}/configuration.nix
      ];
    };
  in {
    nixosConfigurations = {
      ax-mac = mkConfig {
        hostname = "ax-mac";
        username = "ax";
        nixpkgs = nixpkgs-stable;
        home-manager = home-manager-stable;
      };
      ax-bee = mkConfig {
        hostname = "ax-bee";
        username = "ax";
        nixpkgs = nixpkgs-stable;
        home-manager = home-manager-stable;
      };
      ax-vm = mkConfig {
        hostname = "ax-vm";
        username = "ax";
        nixpkgs = nixpkgs-stable;
        home-manager = home-manager-stable;
      };
      ax-srv = mkConfigServer {
        hostname = "ax-srv";
        nixpkgs = nixpkgs-stable;
      };
    };
  };
}
