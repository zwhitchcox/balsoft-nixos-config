{ config, pkgs, inputs, ... }:
let
  EDITOR = pkgs.writeShellScript "codium-editor" ''
    source "/etc/profiles/per-user/balsoft/etc/profile.d/hm-session-vars.sh"
    NIX_OZONE_WL=1 \
    exec \
    ${config.home-manager.users.zwhitchcox.programs.vscode.package}/bin/codium \
    --enable-features=UseOzonePlatform \
    --ozone-platform=wayland \
    -w -n \
    "$@"
  '';
  codium-wayland = pkgs.buildEnv {
    name = "codium-wayland";
    paths = [
      (pkgs.writeShellScriptBin "codium-wayland" ''
        NIX_OZONE_WL=1 \
        exec \
        ${config.home-manager.users.zwhitchcox.programs.vscode.package}/bin/codium \
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland \
        "$@"
      '')
      (pkgs.makeDesktopItem {
        name = "codium-wayland";
        desktopName = "VSCodium (Wayland)";
        exec = "codium-wayland";
        icon = "code";
        categories = [ "Utility" "TextEditor" "Development" "IDE" ];
        mimeTypes = [ "text/plain" "inode/directory" ];
        extraConfig = {
          StartupNotify = "true";
          StartupWMClass = "vscodium";
        };
      })
    ];
  };

  custom-extensions = import ./extensions.nix {
    inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;
  };
in {
  environment.systemPackages = [ codium-wayland ];

  defaultApplications.editor = {
    cmd = "${EDITOR}";
    desktop = "codium-wayland";
  };
  home-manager.users.zwhitchcox = {

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions;
        [
          kahole.magit
          (inputs.direnv-vscode.packages.${pkgs.system}.vsix.overrideAttrs (_: {
            buildPhase = "yarn run build";
            installPhase = ''
              mkdir -p $out/share/vscode/extensions/direnv.direnv-vscode
              cp -R * $out/share/vscode/extensions/direnv.direnv-vscode
            '';
          }))

          (pkgs.callPackage ./theme.nix { } config.themes.colors)

          vscodevim.vim

          matklad.rust-analyzer
          redhat.vscode-yaml
          jnoortheen.nix-ide
          dhall.dhall-lang
          hashicorp.terraform
          timonwong.shellcheck
          bungcip.better-toml
          haskell.haskell
          justusadam.language-haskell
          ms-python.python
          github.vscode-pull-request-github
          eamodio.gitlens
          llvm-vs-code-extensions.vscode-clangd
          stkb.rewrap
          shardulm94.trailing-spaces
        ] ++ pkgs.lib.concatMap builtins.attrValues
        (builtins.attrValues custom-extensions);

      userSettings = {
        "update.mode" = "none";
        "[nix]"."editor.tabSize" = 2;
        "workbench.colorTheme" = "Balsoft's generated theme";
        "terminal.integrated.profiles.linux".bash.path =
          "/run/current-system/sw/bin/bash";
        "terminal.integrated.defaultProfile.linux" = "bash";
        "editor.fontFamily" = "IBM Plex Mono";
        "nix.formatterPath" = "nixfmt";
        "git.autofetch" = true;
        "redhat.telemetry.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        "window.menuBarVisibility" = "toggle";
        "vim.useSystemClipboard" = true;
      };
      keybindings = [{
        key = "ctrl+shift+r";
        command = "workbench.action.tasks.runTask";
        when = "textInputFocus";
      }];
    };
  };
}
