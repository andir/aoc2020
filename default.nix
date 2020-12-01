let
  pkgs = import ./nix;

  inherit (pkgs) lib;
  ps = lib.makeScope pkgs.newScope (super:
    let
      p = import ./packages.nix super;
      self = p // { extend = func: ps // (func ps); };
    in
      self);
in
ps //
  # Used in CI
{ gcroot = pkgs.nLib.mkGcRoot ps; inherit pkgs; }
