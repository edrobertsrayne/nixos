{
  pkgs,
  inputs,
  ...
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    treefmt
    alejandra
    python310Packages.mdformat
    shfmt
    statix
    inputs.agenix.packages."${system}".default
  ];
}
