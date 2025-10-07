{
	description = "foo";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	# outputs = { self, nixpkgs, home-manager, ...}: {
	# 	nixosConfigurations.ax-mac = nixpkgs.lib.nixosSystem {
	# 		system = "x86_64-linux";
	# 		modules = [	
	# 		./configuration.nix
	# 		home-manager.nixosModules.home-manager
	# 		{
	# 			home-manager = {
	# 				useGlobalPkgs = true;
	# 				useUserPackages = true;
	# 				users.ax = import ./home.nix;
	# 				backupFileExtension = "bak";
	# 			};
	# 		}
	# 		];
	# 	};
	# };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";

    # mkHost is a function that takes an attribute set (map/hash like) with name and username as arguments
    # The return value of mkHost is the result of calling the nixosSystem function
    mkHost = { hostname, username }:
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
      ax-mac = mkHost { hostname = "ax-mac"; username = "ax"; };
      ax-desktop = mkHost { hostname = "ax-desktop"; username = "ax"; };
    };
  };
}
