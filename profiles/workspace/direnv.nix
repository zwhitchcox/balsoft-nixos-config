{ config, pkgs, lib, inputs, ... }: {
  home-manager.users.zwhitchcox = {
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
  persist.state.directories =
    [ "/home/balsoft/.local/share/direnv" ];
}
