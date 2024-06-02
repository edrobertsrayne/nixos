{
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      c = ["clangtidy"];
      cpp = ["clangtidy"];
      css = ["eslint_d"];
      dockerfile = ["hadolint"];
      gitcommit = ["commitlint"];
      javascript = ["eslint_d"];
      json = ["jsonlint"];
      lua = ["luacheck"];
      markdown = ["vale" "markdownlint"];
      nix = ["deadnix" "statix"];
      python = ["ruff"];
      sh = ["shellcheck"];
      svelte = ["eslint_d"];
      text = ["vale"];
      typescript = ["eslint_d"];
      yaml = ["yamllint"];
    };
  };
}
