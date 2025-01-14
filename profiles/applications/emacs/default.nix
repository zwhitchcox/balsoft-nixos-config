{ pkgs, config, lib, inputs, ... }:
let
  emacs = pkgs.emacsPgtk;
in {
  # secrets-envsubst.emacs = {
  # owner = "balsoft:users";
  # directory = "emacs";
  # };

  persist.state.homeFiles =
    [ ".config/emacs/custom" ".config/emacs/eshell/history" ];

  defaultApplications.editor = {
    cmd = toString (pkgs.writeShellScript "emacsclient-newwindow" ''
      ${config.home-manager.users.zwhitchcox.programs.emacs.finalPackage}/bin/emacsclient -c "$@"
    '');
    desktop = "emacsclient";
  };

  home-manager.users.zwhitchcox = {
    programs.emacs = {
      enable = true;
      package = emacs;
      extraPackages = epkgs:
        with epkgs; [
          use-package
          nix-mode
          haskell-mode
          exec-path-from-shell
          counsel
          projectile
          which-key
          markdown-mode
          frames-only-mode
          company
          rainbow-delimiters
          diff-hl
          mode-line-bell
          flycheck
          flycheck-pkg-config
          auto-indent-mode
          company-ghci
          expand-region
          ivy
          smex
          quickrun
          counsel-tramp
          ix
          magit
          elixir-mode
          company-box
          ws-butler
          yaml-mode
          gitlab-ci-mode
          gitlab-ci-mode-flycheck
          gitlab
          undo-tree
          rust-mode
          edit-indirect
          idris-mode
          lsp-mode
          envrc
          lsp-haskell
          treemacs
          lsp-treemacs
          treemacs-projectile
          dap-mode
          # forge
          crdt
          base16-theme
          org-caldav
          evil
          tuareg
          fira-code-mode
          terraform-mode
          dhall-mode
        ];
    };

    home.packages = [ pkgs.clang ];

    services.emacs.enable = true;

    systemd.user.services.emacs = {
      Service = {
        Environment =
          "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/balsoft/bin";
      };
      Unit.After = [ "sway-session.target" ];
      Install = {
        WantedBy = lib.mkForce [ "sway-session.target" ];
      };
    };

    xdg.configFile."emacs/init.el".source = pkgs.substituteAll ({
      src = ./init.el;
      font = with config.themes.fonts; "${mono.family} ${toString mono.size}";
    } // pkgs.my-lib.thmHash config.themes.colors);
  };
}
