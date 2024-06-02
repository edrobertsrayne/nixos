{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        action = ":Neotree action=focus toggle filesystem left<cr>";
        options.desc = "Explore NeoTree";
        options.silent = true;
      }
      {
        key = "<leader>fe";
        action = ":Neotree toggle filesystem left<cr>";
        options.desc = "Explore NeoTree";
        options.silent = true;
      }
      {
        key = "<leader>ge";
        action = ":Neotree toggle float git_status<cr>";
        options.desc = "Git explorer";
        options.silent = true;
      }
      {
        key = "<leader>be";
        action = ":Neotree toggle float buffers<cr>";
        options.desc = "Buffer explorer";
        options.silent = true;
      }
    ];
  };
}
