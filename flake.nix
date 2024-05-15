{
  description = "Ed's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # temporary fix while change is merged into the main repo
    snowfall-lib.inputs.flake-utils-plus.url = "github:fl42v/flake-utils-plus";

    nix-colors.url = "github:misterio77/nix-colors";

    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:edrobertsrayne/nixvim";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    the-nix-way.url = "github:the-nix-way/dev-templates";

    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        namespace = "custom";
        meta = {
          name = "dotfiles";
          title = "Ed's Nix dotfiles";
        };
      };

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
          ];

          darwin = with inputs; [
            agenix.nixosModules.default
          ];
        };

        hosts.thinkpad.modules = with inputs; [
          hardware.nixosModules.lenovo-thinkpad-t480s
        ];
      };
    };
}
