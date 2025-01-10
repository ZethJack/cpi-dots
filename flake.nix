{
  description = "Home manager insanity Zeth style";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: {
    homeConfigurations = {
      "zeth" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
