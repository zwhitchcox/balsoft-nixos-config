{ pkgs, config, lib, inputs, ... }: {
  home-manager.users.balsoft.home.packages = with pkgs;
    [
      # Internet
      wget
      curl
      unrar
      neochat
    ] ++ lib.optionals config.deviceSpecific.goodMachine ([
      steamcmd
      steam
      haskellPackages.hoogle
      nixfmt
      niv
      stdman
      libqalculate
      # Messaging
      libnotify
      spectral
      # Audio/Video
      vlc
      lxqt.pavucontrol-qt
      # Tools
      zip
      unrar
      ksysguard
      wl-clipboard
      grim
      slurp
      abiword
      gnumeric
      gcalcli
      breeze-icons
      xdg_utils
      inputs.yt-utilities.defaultPackage.x86_64-linux
      lambda-launcher
      nix-patch
      pass-wayland
      papirus-icon-theme
      gnome3.simple-scan
    ]);
}
