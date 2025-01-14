{ pkgs, config, ... }: {
  home-manager.users.zwhitchcox = {
    home.packages = [ pkgs.cantata ];
    wayland.windowManager.sway = {
      config = {
        assigns."ﱘ" = [{ app_id = "cantata"; }];
      };
    };
    xdg.configFile."cantata/cantata.conf".text = pkgs.my-lib.genIni {
      General = {
        lyricProviders = "azlyrics.com, chartlyrics.com, lyrics.wikia.com";
        wikipediaLangs = "en:en";
        mpris = "true";
        currentConnection = "Default";

        version = pkgs.cantata.version;

        hiddenPages = "PlayQueuePage, LibraryPage, PlaylistsPage, OnlineServicesPage, DevicesPage";
      };

      AlbumView.fullWidthCover = false;

      Connection-Default = {
        host = "localhost";
        passwd = "";
        port = "6600";
      };

      VolumeControl.control = "mpd";
    };
  };

  startupApplications = [ "${pkgs.cantata}/bin/cantata" ];
}
