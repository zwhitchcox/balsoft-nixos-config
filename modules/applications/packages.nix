{ pkgs, config, lib, inputs, ... }: {
  home-manager.users.balsoft.home.packages = with pkgs;
    [
      # Internet
      wget
      curl
      unrar
      neochat
    ] ++ lib.optionals config.deviceSpecific.goodMachine [
      steamcmd
      steam
      haskellPackages.hoogle
      nixfmt
      niv
      stdman
      libqalculate
      github-cli
      # Messaging
      libnotify
      spectral
      # Audio/Video
      vlc
      pavucontrol
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
      xdg_utils
      inputs.yt-utilities.defaultPackage.x86_64-linux
      lambda-launcher
      nix-patch
      pass-wayland
      gopass
      papirus-icon-theme
      gnome3.simple-scan
      shellcheck
      proselint
      inputs.himalaya.defaultPackage.x86_64-linux
    ];
}
