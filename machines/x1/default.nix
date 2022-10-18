{ inputs, lib, ... }: {
  imports = [ ./hardware-configuration.nix inputs.self.nixosRoles.desktop ];
  deviceSpecific.devInfo = {
    cpu = {
      vendor = "intel";
      clock = 2900;
      cores = 20;
    };
    drive = {
      type = "ssd";
      speed = 2000;
      size = 1900;
    };
    ram = 32;
  };

  persist = {
    enable = true;
    cache.clean.enable = true;
  };

  nix.settings.max-jobs = lib.mkDefault 32;
}
