self: with self; {
  helper = callPackage ./helper.nix {};
  day1 = callPackage ./day1 {};
}
