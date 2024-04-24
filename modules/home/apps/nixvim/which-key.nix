{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      registrations = {
        "<leader>g" = "+git";
        "<leader>c" = "+code";
        "<leader>f" = "+file / find";
        "<leader>s" = "+help";
        "<leader>u" = "+ui";
      };
    };
  };
}
