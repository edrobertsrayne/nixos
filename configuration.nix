{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./homelab
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  users.users.root.initialHashedPassword = "$y$j9T$e/DtTAo6OsBLl22niFmga1$XxcLQzrFntBS0RFKs.y2On/cGuR5HtV3BGuuKHk3j75";

  # security.acme = {
  #   acceptTerms = true;
  #   defaults.email = "ed.rayne@gmail.com";
  # };

  age.secrets.tailscale.file = ./secrets/tailscale.age;

  homelab.services = {
    grafana.enable = true;
    prometheus.enable = true;
    loki.enable = true;
  };

  services = {
    tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale.path;
    };
    openssh.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };

    nginx = {
      enable = true;
      recommendedTlsSettings = true;
      recommendedProxySettings = true;
    };

    qemuGuest.enable = true;
  };

  networking = {
    hostName = "nixos";
    firewall = {
      enable = false;
      trustedInterfaces = ["tailscale0"];
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/London";

  environment = {
    persistence."/nix/persist" = {
      directories = [
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/var/lib/tailscale"
      ];
    };
    etc = {
      "ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
      "ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      "ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
      "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
      "machine-id".source = "/nix/persist/etc/machine-id";
    };
    systemPackages = with pkgs; [
      vim
      wget
      curl
      git
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
