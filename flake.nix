{
  description = "Commonly Re-used NixOS Modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosModules = {
      nvidia = import ./hardware/nvidia.nix;
      libvirt = import ./virtualization/libvirt.nix;
    };
  };
}
