{ pkgs, config, lib, ... }: {
  console.font = "cyr-sun16";
  console.keyMap = "ruwin_cplk-UTF-8";

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS =
      "grp:lctrl_toggle,grp_led:caps,ctrl:nocaps,compose:ralt";
    LANG = lib.mkForce "en_GB.UTF-8";
    XCOMPOSEFILE = "${config.home-manager.users.zwhitchcox.xdg.configHome}/XCompose";
  };

  time.timeZone = "Asia/Tbilisi";
  home-manager.users.zwhitchcox = {
    home.file.".XCompose".source = ./compose;
    xdg.configFile."gtk-3.0/Compose".source = ./compose;
    xdg.configFile."XCompose".source = ./compose;
    home.language = let
      en = "en_GB.UTF-8";
      ru = "ru_RU.UTF-8";
    in {
      address = ru;
      monetary = ru;
      paper = ru;
      time = en;
      base = en;
    };
  };
}
