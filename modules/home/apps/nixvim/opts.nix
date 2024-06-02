{
  programs.nixvim = {
    globals.mapleader = " ";
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      number = true;
      relativenumber = true;

      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true;

      smartindent = true;
      shiftwidth = 2;

      breakindent = true;

      wrap = true;
      textwidth = 80;
      colorcolumn = "80";

      splitbelow = true;
      splitright = true;

      fileencoding = "utf-8";

      mouse = "a";

      swapfile = false;
      backup = false;
      undofile = true;

      termguicolors = true;
    };
  };
}
