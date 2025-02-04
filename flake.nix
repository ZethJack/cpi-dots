{
  description = "Home manager insanity Zeth style";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

outputs = { nixpkgs, home-manager, ... }: let
    mkHomeConfig = system: hostname: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [
        ./home.nix
        ({...}: {
          _module.args.hostname = hostname;
        })
      ];
    };
  in {
    homeConfigurations = {
      "zeth@clockworkpi" = mkHomeConfig "aarch64-linux" "clockworkpi";
      "zeth@raspberrypi" = mkHomeConfig "aarch64-linux" "raspberrypi";
      "zeth@nixos" = mkHomeConfig "x86_64-linux" "nixos";
    };
  };
}
