{
  description = "Solis Server";

  inputs = {
    # unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      # url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, nixvim, ... }@inputs:
    let
      inherit (self) outputs;

      systems = [ "x86_64-linux" ];
    in {
      homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        solis = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/server/configuration.nix ];
        };
      };

      homeConfigurations = {
        "sheep@solis" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          modules = [
            ./home-manager/desktop/home.nix # Base desktop config
            {
              home = {
                username = "sheep";
                homeDirectory = "/home/sheep";
              };
              programs.home-manager.enable = true;
              targets.genericLinux.enable = true;
              home.stateVersion = "25.05";
            }
          ];
          extraSpecialArgs = inputs;

        };
      };
    };
}
