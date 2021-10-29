{ config, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.self.nixosRoles.desktop
    inputs.self.nixosProfiles.print-scan
    inputs.self.nixosProfiles.aws
  ];
  deviceSpecific.devInfo = {
    cpu = {
      vendor = "amd";
      clock = 4200;
      cores = 8;
    };
    drive = {
      type = "ssd";
      speed = 6000;
      size = 250;
    };
    bigScreen = true;
    ram = 32;
  };
  deviceSpecific.isHost = true;
  services.apcupsd.enable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  secrets.wireguard-wg0 = { };

  environment.sessionVariables.WINEPREFIX = "/home/balsoft/.local/share/wineprefixes/default";

  persist = {
    enable = true;
    cache.clean.enable = false; # Scary...

    state.directories = [ "/home/balsoft/.local/share/Steam" ];

    derivative.directories = [ "/home/balsoft/.local/share/wineprefixes/default" ];
  };
}
