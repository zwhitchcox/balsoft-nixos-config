{ pkgs, config, ... }: {
  home-manager.users.balsoft = {
    systemd.user.services.mako = {
      Service = {
        ExecStart = "${pkgs.mako}/bin/mako";
      };
      Install = {
        After = [ "sway-session.target" ];
        WantedBy = [ "sway-session.target" ];
      };
    };
    programs.mako = with (pkgs.my-lib.thmHash config.themes.colors); {
      enable = true;
      layer = "overlay";
      font = with config.themes.fonts; "${main.family} ${toString main.size}";
      width = 500;
      height = 80;
      defaultTimeout = 10000;
      maxVisible = 10;
      backgroundColor = "${base00}AA";
      textColor = base05;
      borderColor = "${base0D}AA";
      progressColor = "over ${base0B}";
      iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      maxIconSize = 24;
      extraConfig = ''
        [mode=do-not-disturb]
        invisible=1
        [mode=do-not-disturb summary="Do not disturb: on"]
        invisible=0
        [mode=concentrate]
        invisible=1
        [mode=concentrate urgency=critical]
        invisible=0
        [mode=concentrate summary="Concentrate mode: on"]
        invisible=0
      '';
    };
  };
}
