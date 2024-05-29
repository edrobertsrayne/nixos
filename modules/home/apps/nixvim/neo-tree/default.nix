{
  programs.nixvim = {
    plugins.neo-tree = {enable = true;};

    keymaps = [
      {
        key = "<leader>e";
        action = ":Neotree toggle filesystem left<cr>";
        options.desc = "Explore NeoTree";
      }
      {
        key = "<leader>fe";
        action = ":Neotree toggle filesystem left<cr>";
        options.desc = "Explore NeoTree";
      }
      {
        key = "<leader>ge";
        action = ":Neotree toggle float git_status<cr>";
        options.desc = "Git explorer";
      }
      {
        key = "<leader>be";
        action = ":Neotree toggle float buffers<cr>";
        options.desc = "Buffer explorer";
      }
    ];
  };
}
