# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  unstablePkgs =
    import
    (builtins.fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz")
    {};
in {
  imports = [./hardware-configuration.nix <home-manager/nixos>];

  boot.loader = {
    systemd-boot = {enable = true;};

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Configure nix itself
  nix = {
    settings = {
      # Experimental Features
      experimental-features = ["nix-command" "flakes"];

      # Maximum number of concurrent tasks during one build
      cores = 4;

      max-jobs = 16;

      # Perform builds in a sandboxed environment
      sandbox = true;

      # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
      auto-optimise-store = true;

      substituters = ["https://hyprland.cachix.org" "https://nix-community.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
  };

  networking = {networkmanager.enable = true;};

  # Set your time zone.
  time.timeZone = "Asia/Dubai";

  i18n.defaultLocale = "en_US.utf8";

  # Hardware configuration
  hardware = {bluetooth = {enable = true;};};

  # Blueman
  services.blueman = {enable = true;};

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Polkit
  security.polkit.enable = true;

  # OpenGL
  hardware.opengl.enable = true;

  # Define my user account.
  users.users.rei = {
    isNormalUser = true;
    description = "Rei Star";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.canon-cups-ufr2];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts = {
    fonts = with pkgs; [
      twemoji-color-font
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {fonts = ["FantasqueSansMono"];})
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "FantasqueSansMono Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment = {
    # Add zsh to /etc/shells
    shells = [pkgs.zsh];

    # List packages installed in system profile (globally).
    systemPackages = with pkgs; [
      wget
      git
      home-manager
      pipewire
      wireplumber
      pulseaudio
      zsh
      unzip
      gnupg
    ];

    pathsToLink = ["/share/zsh"];
  };

  systemd.services = {
    seatd = {
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
        ExecStart = "${pkgs.seatd}/bin/seatd -g wheel";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  system.stateVersion = "22.05";
}
