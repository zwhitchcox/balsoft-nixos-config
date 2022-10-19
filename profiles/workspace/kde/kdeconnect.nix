{
  home-manager.users.zwhitchcox = {
    services.kdeconnect.enable = true;
  };
  persist.state.directories = [ "/home/balsoft/.config/kdeconnect" ];
}
