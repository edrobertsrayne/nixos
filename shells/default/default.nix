{
  pkgs,
  inputs,
  ...
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    treefmt
    alejandra
    shfmt
    statix
    inputs.agenix.packages."${system}".default
  ];
}
