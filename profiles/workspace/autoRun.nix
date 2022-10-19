{ config, pkgs, lib, ... }: {
  home-manager.users.zwhitchcox = {
    programs.nix-index.enable = true;
  };

  environment.sessionVariables = {
    NIX_AUTO_RUN = "1";
  };
}
