{ pkgs, ... }: {
  home-manager.users.zwhitchcox.wayland.windowManager.sway.config.startup = [{
    command = toString (pkgs.writeShellScript "slack" ''
      firefox https://tweag.slack.com &
      sleep 10
      swaymsg '[title=Slack.*] move to workspace '
      swaymsg '[title=Slack.*] fullscreen disable'
    '');
  }];
}
