let
  imac = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0EYKmro8pZDXNyT5NiBZnRGhQ/5HlTn5PJEWRawUN1";
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDkIYQ9LaTuLo7cuK/ZbdmSi8F+W6zRcxv9zwQ7kc8Lc";
  systems = [imac nixos];
in {
  "pve-exporter.age".publicKeys = systems;
  "tailscale.age".publicKeys = systems;
}
