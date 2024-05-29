{
  programs.nixvim = {
    plugins.todo-comments = {
      enable = true;
    };
    keymaps = [
      {
        action = ''lua require("todo-comments").jump_next()<cr>'';
        key = "]t";
        options.desc = "Next Todo Comment";
      }
      {
        action = ''lua require("todo-comments").jump_prev()<cr>'';
        key = "[t";
        options.desc = "Previous Todo Comment";
      }
      {
        action = "<cmd> TodoTrouble <cr>";
        key = "<leader>xt";
        options.desc = "Todo (Trouble)";
      }
      {
        action = "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>";
        key = "<leader>xT";
        options.desc = "Todo/Fix/Fixme (Trouble)";
      }
      {
        action = "<cmd> TodoTelescope <cr>";
        key = "<leader>st";
        options.desc = "Todo (Telescope)";
      }
      {
        action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
        key = "<leader>sT";
        options.desc = "Todo/Fix/Fixme (Telescope)";
      }
    ];
  };
}
