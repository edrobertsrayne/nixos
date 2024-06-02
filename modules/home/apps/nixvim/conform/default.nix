{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notifyOnError = true;
      formattersByFt = {
        css = [["prettierd" "prettier"]];
        html = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        python = ["isort" "black"];
        java = ["google-java-format"];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [["prettierd" "prettier"]];
        rust = ["rustfmt"];
        yaml = ["yamllint" "yamlfmt"];
        c = [["astyle" "clang-format"]];
        "*" = ["codespell"]; # run on all filetypes
        "_" = ["trim_whitespace"]; # run on filetypes with no formatter
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Buffer";
        };
      }

      {
        mode = "v";
        key = "<leader>cF";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          silent = true;
          desc = "Format Lines";
        };
      }
    ];
  };
}
