{
  description = "Home Manager configuration of tomek";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim.url = "github:nix-community/nixvim";
    nixgl.url = "github:nix-community/nixGL";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
       url = "github:numtide/treefmt-nix";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs =
    inputs@{
      flake-parts,
      home-manager,
      nixpkgs,
      nixvim,
      nixgl,
      treefmt-nix,
      git-hooks,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # Import home-manager's flake module
        inputs.home-manager.flakeModules.home-manager
      ];
      flake = {

        # Concrete Home Manager configuration.
        homeConfigurations.tomek = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [
              nixgl.overlay
            ];
          };

          # reefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
          # preCommit = git-hooks.lib.${system}.run {
          #   src = ./.;
          #   hooks = {
          #     nixfmt-rfc-style = {
          #       enable = true;
          #       package = pkgs.nixfmt;
          #     };
          #     statix.enable = true;
          #     shellcheck.enable = true;
          #   };
          # };

          modules = [
            ./home.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };

}
