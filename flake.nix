{
  description = "Ed's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      # url = "github:edrobertsrayne/nixvim";
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    the-nix-way.url = "github:the-nix-way/dev-templates";

    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      src = ./.;
      inherit inputs;

      snowfall = {
        namespace = "custom";
        meta = {
          name = "dotfiles";
          title = "Ed's Nix dotfiles";
        };
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      templates =
        import ./templates {}
        // inputs.the-nix-way.templates;

      systems = {
        modules = {
          nixos = with inputs; [
            home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            stylix.nixosModules.stylix
          ];

          darwin = with inputs; [
            agenix.nixosModules.default
            stylix.darwinModules.stylix
          ];
        };

        hosts.thinkpad.modules = with inputs; [
          hardware.nixosModules.lenovo-thinkpad-t480s
        ];
      };
    };
}
