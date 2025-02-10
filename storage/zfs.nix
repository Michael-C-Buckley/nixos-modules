{pkgs, lib, ...}: {
  boot = {
    kernelModules = ["zfs"];
    supportedFilesystems = ["zfs"];
    zfs = {
      devNodes = "/dev/disk/by-partuuid";
      forceImportRoot = false;
      requestEncryptionCredentials = lib.mkDefault false;
    };
  };

  services.zfs.autoScrub.enable = true;

  environment.systemPackages = with pkgs; [
    zfs
  ];
}
