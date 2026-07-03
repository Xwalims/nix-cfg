{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    freesm.url = "github:FreesmTeam/FreesmLauncher";
    helium.url = "github:vikingnope/helium-browser-nix-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, spicetify-nix, ... }@inputs: { # Added spicetify-nix here
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix 
        spicetify-nix.nixosModules.default # Add the module here
      ];
    };
  };
}

