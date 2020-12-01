self: with self; rec {
  haskell = callPackage ./haskell { };
  rust = callPackage ./rust { };
}
