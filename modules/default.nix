device:
{ pkgs, lib, ... }: {
  imports = [
    ./applications/packages.nix
    ./applications/emacs
    ./applications/konsole.nix
    # ./applications/trojita.nix
    ./applications/sylpheed.nix
    ./applications/weechat.nix
    ./applications/okular.nix
    ./applications/yt-utilities.nix
    ./applications/firefox.nix
    ./workspace/autofs.nix
    ./workspace/i3
    ./workspace/i3blocks
    ./workspace/zsh.nix
    ./workspace/gtk.nix
    ./workspace/misc.nix
    ./workspace/kde
    ./workspace/ssh.nix
    ./workspace/locale.nix
    ./workspace/fonts.nix
    ./workspace/light.nix
    ./workspace/mako.nix
    ./workspace/mopidy.nix
    ./workspace/gcalcli.nix
    ./workspace/rclone.nix
    ./workspace/xresources.nix
    ./themes.nix
    ./applications.nix
    ./secrets.nix
    ./devices.nix
    ./packages.nix
    ./users.nix
    ./hardware.nix
    ./services.nix
    ./power.nix
    ./network.nix
  ] ++ lib.optionals (device == "AMD-Workstation") [
    ./mailserver.nix
    ./matrix-synapse.nix
    ./workspace/kanshi.nix
    ./openvpn.nix
    ./nginx.nix
    ./gitea.nix
  ];
}
