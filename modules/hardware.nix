{ pkgs, config, lib, ... }:

with rec { inherit (config) device devices deviceSpecific; };
with deviceSpecific; {

  hardware.sensor.iio.enable = (device == "HP-Laptop");
  hardware.cpu.${devices.${device}.cpu.vendor}.updateMicrocode =
    true; # Update microcode

  hardware.enableRedistributableFirmware = true; # For some unfree drivers

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true; # For steam

  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  hardware.sane.enable = true;

  services.throttled = {
    enable = device == "T490s-Laptop";
    extraConfig = ''
      [GENERAL]
      # Enable or disable the script execution
      Enabled: True
      # SYSFS path for checking if the system is running on AC power
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online

      ## Settings to apply while connected to Battery power
      [BATTERY]
      # Update the registers every this many seconds
      Update_Rate_s: 30
      # Max package power for time window #1
      PL1_Tdp_W: 29
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 85
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 1

      ## Settings to apply while connected to AC power
      [AC]
      # Update the registers every this many seconds
      Update_Rate_s: 5
      # Max package power for time window #1
      PL1_Tdp_W: 44
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 95
      # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
      HWP_Mode: True
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 2

      [UNDERVOLT]
      # CPU core voltage offset (mV)
      CORE: -200
      # Integrated GPU voltage offset (mV)
      GPU: -60
      # CPU cache voltage offset (mV)
      CACHE: -50
      # System Agent voltage offset (mV)
      UNCORE: 0
      # Analog I/O voltage offset (mV)
      ANALOGIO: 0
    '';
  };
  boot.kernelModules = [ "ec_sys" ];
  systemd.services.thinkpad_leds = {
    enable = config.device == "T490s-Laptop";
    description = "Set up thinkpad leds";
    wantedBy = [ "multi-user.target" ];
    script = ''echo -n -e "\x0e" | dd of="/sys/kernel/debug/ec/ec0/io" bs=1 seek=12 count=1 conv=notrunc 2> /dev/null'';
    serviceConfig.Type = "oneshot";
  };

  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.useOSProber = true;
      timeout = 1;
    } // (if deviceSpecific.devInfo.legacy or false then { # Non-UEFI config
      grub.device = "/dev/sda";
    } else { # UEFI config
      grub.efiSupport = true;
      grub.device = "nodev";
      grub.efiInstallAsRemovable = true; # NVRAM is unreliable
    });
    consoleLogLevel = 3;
    blacklistedKernelModules = lib.optionals (device == "Prestigio-Laptop") [
      "axp288_charger"
      "axp288_fuel_gauge"
      "axp288_adc"
    ]; # Disable battery driver as it hangs this piece of shit
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    extraModprobeConfig = "options ec_sys write_support=1";
    kernel.sysctl."vm.swappiness" = 0;
    kernelPackages = pkgs.linuxPackages;
    kernel.sysctl."kernel/sysrq" = 1;
    kernelParams = [
      "quiet"
      "scsi_mod.use_blk_mq=1"
      "modeset"
      "nofb"
      "rd.systemd.show_status=auto"
      "rd.udev.log_priority=3"
      "pti=off"
      "spectre_v2=off"
    ] ++ lib.optionals (device == "Prestigio-Laptop") [
      "intel_idle.max_cstate=1" # Otherwise it hangs
    ];
  };

  services.logind.lidSwitchExternalPower = "ignore";

  services.logind.extraConfig = "HandlePowerKey=suspend";
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    # systemWide = true;
    extraConfig = ''
      load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1
    '';
    extraModules = [ pkgs.pulseaudio-modules-bt ];
  };

  services.dbus.packages = [ pkgs.blueman ];
}
