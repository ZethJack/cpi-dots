{
  description = "Home manager insanity Zeth style";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        hashbrown = mkSystem ./hosts/hashbrown/configuration.nix;
        potatOS = mkSystem ./hosts/potatOS/configuration.nix;
      };

      homeConfigurations = {
        # ================ Maintained home configurations ================ #

        "zeth@clockworkpi" = mkHome "aarch64-linux" ./hosts/clockworkpi/home.nix;
        "zeth@raspberrypi" = mkHome "aarch64-linux" ./hosts/raspberrypi/home.nix;
        "zeth@hashbrown" = mkHome "x86_64-linux" ./hosts/hashbrown/home.nix;
        "zeth@potatOS" = mkHome "x86_64-linux" ./hosts/potatOS/home.nix;

        # ========================= Discontinued ========================= #
        # This one doesn't work. Left it in case I ever want to use it again

        # "yurii@osxvm" = mkHome "x86_64-darwin" ./hosts/osxvm/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
# outputs = { nixpkgs, home-manager, ... }: let
#     mkHomeConfig = system: hostname: home-manager.lib.homeManagerConfiguration {
#       pkgs = nixpkgs.legacyPackages.${system};
#       modules = [
#         ./home.nix
#         ({...}: {
#           _module.args.hostname = hostname;
#         })
#       ];
#     };
#   in {
#     homeConfigurations = {
#       "zeth@clockworkpi" = mkHomeConfig "aarch64-linux" "clockworkpi";
#       "zeth@raspberrypi" = mkHomeConfig "aarch64-linux" "raspberrypi";
#       "zeth@nixos" = mkHomeConfig "x86_64-linux" "nixos";
#     };
#   };
# }

