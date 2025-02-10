# Libvirt Common
# - Users may need to be added to KVM group
# - Assumes `br0` exists as the bridge

{pkgs, lib, ...}: let
  ovmfList = [
    (pkgs.OVMF.override {
      secureBoot = true;
      tpmSupport = true;
    }).fd];
in {
  environment.systemPackages = with pkgs; [
    virt-viewer
    virt-manager
    tigervnc
  ];

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = lib.mkDefault ["br0"];
    parallelShutdown = 5;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = ovmfList;
      };
    };
  };
}
