{ pkgs, lib, config, ... }: {
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  persist.derivative.directories = [ "/home/balsoft/.local/share/gnupg" ];

  home-manager.users.zwhitchcox = {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gtk2";
    };

    systemd.user.services.gpg-agent = {
      Service = {
        Environment = lib.mkForce [
          "GPG_TTY=/dev/tty1"
          "DISPLAY=:0"
          "GNUPGHOME=${config.home-manager.users.zwhitchcox.xdg.dataHome}/gnupg"
        ];
      };
    };

    programs.gpg = {
      enable = true;
      homedir = "${config.home-manager.users.zwhitchcox.xdg.dataHome}/gnupg";
      scdaemonSettings = {
        disable-ccid = true;
        reader-port = "Yubico Yubi";
      };
    };
  };
}
