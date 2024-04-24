{
  inputs,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.nixvim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./cmp.nix
    #./colorscheme.nix
    ./keymaps.nix
    ./lazygit.nix
    ./lsp.nix
    ./noice.nix
    ./none-ls.nix
    ./oil.nix
    ./opts.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  options.apps.nixvim.enable = mkEnableOption "nixvim";

  config =
    mkIf cfg.enable
    {
      programs.nixvim = {
        enable = true;
        defaultEditor = true;

        colorschemes.catppuccin.enable = true;

        globals.mapleader = " ";
        plugins = {
          bufferline.enable = true;
          lualine.enable = true;
          tmux-navigator.enable = true;
          nix.enable = true;
          nvim-colorizer.enable = true;
          nvim-autopairs.enable = true;
          #indent-blankline.enable = true;
          neo-tree = {enable = true;};
          trouble = {enable = true;};
          # lsp-lines.enable = true;

          alpha = {
            enable = true;
            theme = "startify";
          };
        };
      };
    };
}
