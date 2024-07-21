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
    mdformat
    vale
    markdownlint-cli
  ];
}
