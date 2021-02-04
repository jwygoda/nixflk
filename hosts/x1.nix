{ lib, pkgs, ... }:
let inherit (builtins) readFile;
in
{
  imports =
    [
      ../users/xddd
    ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a4df8527-c770-494e-a199-9ec3f6ab8c58";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/9D2B-BDE6";
      fsType = "vfat";
    };

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];

  boot.kernelModules = [ "kvm-intel" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot = {
    enable = true;
    editor = false;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
