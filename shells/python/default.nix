{pkgs, ...}: let
  python-env = pkgs.python3.withPackages (pp:
    with pp; [
      pip
      wheel
      cython
      isort
    ]);
in
  pkgs.mkShell {
    buildInputs = [
      python-env
      pkgs.ruff
      pkgs.zsh
    ];

    shellHook = ''
      [[ -d .venv ]] || python -m venv .venv
      source .venv/bin/activate
      exec zsh
    '';
  }
