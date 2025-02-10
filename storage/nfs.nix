{pkgs, ...}: {
  boot = {
    supportedFilesystems = ["nfs"];
  };

  services = {
    nfs.server.enable = true;
    rpcbind.enable = true;
  };

  environment.systemPackages = with pkgs; [
    nfs-utils
  ];
}
