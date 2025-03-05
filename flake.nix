{
  description = "Commonly Re-used NixOS Modules";

  inputs = {
    # User override is expected
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-devshells = {
      url = "github:Michael-C-Buckley/nix-devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nix-devshells, ...}: {
    nixosModules = {
      nvidia = import ./hardware/nvidia.nix;
      libvirt = import ./virtualization/libvirt.nix;

      ceph = import ./storage/ceph.nix;
      nfs = import ./storage/nfs.nix;
      zfs = import ./storage/zfs.nix;

      wireguard-interface = import ./network/wireguard-interface.nix {};
    };

    checks = nix-devshells.checks;
    devShells.x86_64-linux.default = nix-devshells.devShells.x86_64-linux.nixos;
  };
}
