{ pkgs, config, lib, inputs, ... }: {
  home-manager.users.zwhitchcox.home.packages = with pkgs;
    [
      # Internet
      wget
      curl

      exa
      jq
    ] ++ lib.optionals config.deviceSpecific.goodMachine [
      # steamcmd
      # steam
      haskellPackages.hoogle
      nixfmt
      nixpkgs-fmt
      stdman
      libqalculate
      # Messaging
      libnotify
      # Audio/Video
      mpv
      vlc
      pavucontrol
      # Tools
      zip
      plasma-systemmonitor
      wl-clipboard
      grim
      slurp
      abiword
      gnumeric
      gcalcli
      xdg_utils
      lambda-launcher
      nix-patch
      gopass
      papirus-icon-theme
      shellcheck
      proselint
      ripgrep
      bat
      jless

      pandoc
      codebraid
    ];
}
