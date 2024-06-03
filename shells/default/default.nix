{
  pkgs,
  inputs,
  ...
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    alejandra
    statix
    deadnix
    codespell
    inputs.agenix.packages."${system}".default
  ];
}
