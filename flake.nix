{
	description = "foo";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    mkConfig = { hostname, username }:
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
  in {
    nixosConfigurations = {
      ax-mac = mkConfig { hostname = "ax-mac"; username = "ax"; };
      ax-bee = mkConfig { hostname = "ax-bee"; username = "ax"; };
      ax-vm = mkConfig { hostname = "ax-vm"; username = "ax"; };
    };
  };
}
