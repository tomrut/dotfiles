{
  description = "NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixvim,
      ...
    }:

    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

    in {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs; 
          inherit nixpkgs-unstable; 
        };
        modules = [

          ./laptop/configuration.nix
          ./common/swaywm.nix
          #./common/stub-ld.nix
          #./common/mango.nix
          #./common/plasma.nix
          ./common/mounting.nix
          # ./common/podman.nix
          #./common/monitoring.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; inherit pkgs-unstable; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tomek = import ./home-manager/home-laptop.nix;
          }
        ];
      };

      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./desktop/configuration.nix
          ./common/swaywm.nix
          #./common/stub-ld.nix
          #./common/plasma.nix
          #./common/podman.nix
          ./common/mounting.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { 
              inherit inputs;
              inherit pkgs-unstable;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tomek = import ./home-manager/home-desktop.nix;
          }
        ];
      };
    };
}
