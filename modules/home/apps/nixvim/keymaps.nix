{
  programs.nixvim.keymaps = [
    {
      key = "<leader>e";
      action = ":Neotree toggle filesystem left<cr>";
      options.desc = "Explore NeoTree";
    }
    {
      key = "<leader>ge";
      action = ":Neotree toggle float git_status<cr>";
      options.desc = "Explore Git NeoTree";
    }
  ];
}
