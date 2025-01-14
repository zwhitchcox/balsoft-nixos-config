{ pkgs, lib, config, inputs, ... }: {

  environment.sessionVariables =
    config.home-manager.users.zwhitchcox.home.sessionVariables // rec {
      LESS = "MR";
      LESSHISTFILE = "~/.local/share/lesshist";

      CARGO_HOME = "${config.home-manager.users.zwhitchcox.xdg.dataHome}/cargo";

      SYSTEMD_LESS = LESS;
    };

  home-manager.users.zwhitchcox = {
    news.display = "silent";

    systemd.user.startServices = true;

    home.stateVersion = "20.09";
  };

  home-manager.useGlobalPkgs = true;

  persist.cache.directories = [ "/home/balsoft/.cache" "/home/balsoft/.local/share/cargo" "/var/cache" ];

  persist.state.directories = [ "/var/lib/nixos" "/var/lib/systemd" ];

  system.stateVersion = lib.mkDefault "18.03";

  systemd.services.systemd-timesyncd.wantedBy = [ "multi-user.target" ];

  systemd.timers.systemd-timesyncd = { timerConfig.OnCalendar = "hourly"; };

  services.avahi.enable = true;

  environment.systemPackages = [ pkgs.ntfs3g ];
}
