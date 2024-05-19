let
  users = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0EYKmro8pZDXNyT5NiBZnRGhQ/5HlTn5PJEWRawUN1 ed@imac"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHEmqNg3PgPOlRY/YKVoXFPj5OXXcFatOPTIAXtVRaR1 ed@macbook-air"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOv0/iaSik9qILGe4RmUZodSy9AxKbr4w9RvLyRTvMJ ed@thinkpad"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMA6YNB0ivJt5Wij0g7hb9TENZHnJWi6rsw6PQmH0ZK ed@nixpi"
  ];
  systems = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINYyLunmctaWVs/6s5wGwbNyXopjTOfxMFk0BTBT0kyy root@nixos"
  ];
in {
  "wireguard.age".publicKeys = systems ++ users;
}
