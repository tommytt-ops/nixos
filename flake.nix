{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
	    url = "github:hyprwm/hyprland-plugins";
	    inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
  let 
    username = "tommyt";
    home = "/home/tommyt";
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    pythonEnv = import ./modules/devShell/python.nix {
      pkgs = pkgs;
      lib = nixpkgs.lib;
    };
  in {

    modules = {
      python = pythonEnv;
    };
    
      nixosConfigurations = {

	      default = nixpkgs.lib.nixosSystem {
	        specialArgs = {inherit inputs username home;};
	          modules = [
	            ./hosts/default/configuration.nix
	            inputs.stylix.nixosModules.stylix
	            inputs.home-manager.nixosModules.default
	          ];
	      };

        hydra = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs username home;};
            modules = [
              ./hosts/hydra/configuration.nix
              ./hosts/hydra/hardware-configuration.nix
              inputs.stylix.nixosModules.stylix
              inputs.home-manager.nixosModules.default
            ];
        };

        laptop = nixpkgs.lib.nixosSystem {
	        specialArgs = {inherit inputs username home;};
	          modules = [
	            ./hosts/laptop/configuration.nixi
	            inputs.stylix.nixosModules.stylix
	            inputs.home-manager.nixosModules.default
	          ];
	      };
      };

      devShells."x86_64-linux".default = pkgs.mkShell {
        packages = with pkgs; [
          openssh
          git
          python311
          openssl
        ] ++ pythonEnv.buildInputs;

        shellHook = ''
          openssl s_client -connect google.com:443 -servername google.com </dev/null
        '';
     };
  };
}

