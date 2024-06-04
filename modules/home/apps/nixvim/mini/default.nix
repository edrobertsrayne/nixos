let
  header = ''
    ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
    ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
    ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

          git@github.com:edrobertsrayne
  '';
  footer = ''
    "I don't like it, and I'm sorry I ever had
    anything to do with it."
                            - Erwin Schrodinger
  '';
in {
  programs.nixvim.plugins.mini = {
    enable = true;
    modules = {
      animate = {};
      ai = {};
      basics = {
        options = {
          basic = true;
          extra_ui = false;
          win_borders = "default"; # single, double, default...
        };
        mappings = {
          basic = true;
          option_toggle_prefix = ''[[\]]'';
          windows = true;
          move_with_alt = false;
        };
        autocommands = {
          basic = true;
          relnum_in_visual_mode = false;
        };
        silent = false;
      };
      comment = {};
      pairs = {};
      surround = {};
      starter = {
        autoopen = true;
        inherit header footer;
      };
    };
  };
}
