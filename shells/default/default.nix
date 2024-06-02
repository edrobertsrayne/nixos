{
  pkgs,
  inputs,
  ...
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    #treefmt
    alejandra
    #shfmt
    statix
    deadnix
    codespell
    inputs.agenix.packages."${system}".default
  ];
}
