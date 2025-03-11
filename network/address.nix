_: cidr: let
  parts = builtins.split "/" cidr;
in {
  address = builtins.elemAt parts 0;
  prefixLength = builtins.toInt (builtins.elemAt parts 1);
}