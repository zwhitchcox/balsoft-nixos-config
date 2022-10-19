{ config, pkgs, lib, ... }: {
  home-manager.users.zwhitchcox.systemd.user.services.yubikey-touch-detector = {
    Service = {
      Environment = [ "PATH=${lib.makeBinPath [ pkgs.gnupg pkgs.yubikey-touch-detector ]}" ];
      ExecStart = toString (pkgs.writeShellScript "yubikey-touch-detector" ''
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        yubikey-touch-detector -libnotify
      '');
    };
    Install = rec {
      WantedBy = [ "graphical-session.target" ];
      Wants = [ "gpg-agent-ssh.socket" "gpg-agent.socket" ];
      After = Wants;
    };
  };
}
