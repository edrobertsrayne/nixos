{
  programs.nixvim.plugins.none-ls = {
    enable = false;
    enableLspFormat = true;
    updateInInsert = false;
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        statix.enable = true;
        deadnix.enable = true;
        pylint.enable = true;
        checkstyle.enable = true;
        yamllint.enable = true;
        cmake_lint.enable = true;
        cppcheck.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        black = {
          enable = true;
          withArgs = ''
            {
              extra_args = { "--fast" },
            }
          '';
        };
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
          withArgs = ''
            {
              extra_args = { "--no-semi", "--single-quote" },
            }
          '';
        };
        stylua.enable = true;
        yamlfmt.enable = true;
        astyle.enable = true;
        cmake_format.enable = true;
        clang_format.enable = true;
        shfmt.enable = true;
        nixpkgs_fmt.enable = true;
      };
      completion = {
        luasnip.enable = true;
        spell.enable = true;
      };
    };
  };
}
