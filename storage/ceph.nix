{pkgs,...}: {
  services.ceph = {
    enable = true;
    mon.enable = true;
    osd = {
      enable = true;
      daemons = ["0"];
    };
  };

  users = {
    groups.ceph = {};
    users.ceph = {
      isNormalUser = true;
      extraGroups = ["wheel" "ceph"];
    };
  };

  environment.systemPackages = with pkgs; [
    ceph
  ];
}
