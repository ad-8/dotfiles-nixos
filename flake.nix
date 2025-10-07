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
    mkHost = { name, username }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/${name}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./hosts/${name}/home.nix;
            backupFileExtension = "bak";
          };
        }
      ];
    };
  in {
    nixosConfigurations = {
      ax-mac = mkHost { name = "ax-mac"; username = "ax"; };
      ax-desktop = mkHost { name = "ax-desktop"; username = "ax"; };
    };
  };
}
