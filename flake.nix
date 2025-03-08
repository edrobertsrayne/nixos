{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    agenix.url = "github:ryantm/agenix";
  };
  outputs = {
    nixpkgs,
    impermanence,
    agenix,
    ...
  } @ inputs: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {system = "x86_64-linux";};
        specialArgs = {inherit inputs;};
      };
      nixos = {
        deployment = {
          targetHost = "nixos";
          targetPort = 22;
          targetUser = "root";
          buildOnTarget = true;
          tags = ["homelab"];
        };
        time.timeZone = "Europe/London";
        imports = [
          impermanence.nixosModules.impermanence
          agenix.nixosModules.default
          ./configuration.nix
        ];
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        impermanence.nixosModules.impermanence
        ./configuration.nix
      ];
    };
  };
}
