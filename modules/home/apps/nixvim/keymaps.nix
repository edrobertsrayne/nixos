{
  programs.nixvim.keymaps = [
    # Files

    {
      key = "<leader>fn";
      action = "<cmd>enew<cr>";
      options.desc = "New file";
    }

    # Indenting

    {
      key = "<";
      action = "<gv";
      mode = "v";
    }
    {
      key = ">";
      action = ">gv";
      mode = "v";
    }

    # Terminal

    {
      key = "<esc><esc>";
      action = "<c-\\><c-n>";
      options.desc = "Enter normal mode";
      mode = "t";
    }
  ];
}
