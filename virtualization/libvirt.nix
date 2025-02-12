{config, pkgs, lib, ...}: let
  virtCfg = config.custom.virtualisation.libvirt;
  ovmfList = [
    (pkgs.OVMF.override {
      secureBoot = true;
      tpmSupport = true;
    }).fd];
in {
  options.custom.virtualisation.libvirt = {
    enable = {
      type = lib.types.bool;
      default = true;
      description = "Enable libvirt on the host.";
    };
    addPkgs = {
      type = lib.types.bool;
      default = true;
      description = "Add graphical support packages for VMs.";
    };
    users = {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of users to add the `KVM` group to.";
    };
    bridge = {
      type = lib.types.str;
      default = "br0";
      description = "Name of the bridge device to bind for Libvirt.";
    };
  };

  config = {
    environment.systemPackages = with pkgs; lib.optionals virtCfg.addPkgs [
      virt-viewer
      virt-manager
      tigervnc
    ];

    users.users = lib.attrsets.genAttrs virtCfg.users (_: {
      extraGroups = ["KVM"];
    });

    virtualisation.libvirtd = {
      enable = true;
      allowedBridges = lib.mkDefault config.options.customer;
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
  };
}
