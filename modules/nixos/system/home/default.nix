{
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = [inputs.home-manager.nixosModules.home-manager];

  environment.systemPackages = with pkgs; [home-manager];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
