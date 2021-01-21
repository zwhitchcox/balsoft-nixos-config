{ pkgs, lib, config, inputs, ... }: {
  systemd.coredump.enable = true;

  environment.sessionVariables = config.home-manager.users.balsoft.home.sessionVariables // {
    NIX_AUTO_RUN = "1";
  };

  home-manager.users.balsoft = {
    xdg.enable = true;

    home.activation."mimeapps-remove" = {
      before = [ "linkGeneration" ];
      after = [ ];
      data = "rm -f /home/balsoft/.config/mimeapps.list";
    };

    news.display = "silent";
    programs.command-not-found = {
      enable = true;
      dbPath = ../../misc/programs.sqlite;
    };
    systemd.user.startServices = true;
  };


  home-manager.users.balsoft.home.stateVersion = "20.09";

  system.stateVersion = "18.03";

}
