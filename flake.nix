{
  description = "Home Manager configuration of parzival";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    catppuccin.url = "github:catppuccin/nix";
    nix-colors.url = "github:misterio77/nix-colors";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap-flake.url = "github:xremap/nix-flake";
    steam-tui.url = "github:dmadisetti/steam-tui";
  };

  outputs = { nixpkgs, nixpkgs-stable , home-manager, nix-index-database, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; overlays = [ inputs.nur.overlay ];  };
      stable-pkgs = import nixpkgs-stable { system = system; config.allowUnfree = true; };
    in {
      homeConfigurations."parzival" = home-manager.lib.homeManagerConfiguration {
	      inherit pkgs;
	      extraSpecialArgs = { inherit inputs; inherit stable-pkgs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix 
          nix-index-database.hmModules.nix-index
          catppuccin.homeManagerModules.catppuccin
        ];
      };
    };
}
