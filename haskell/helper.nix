{ pkgs }:
{
  # Create the common attributes for a haskell application
  # Returns an attribute set with `app` being the derivation of the application
  # and `shell` being the shell expression for the application.
  mkHaskellApp =
    { src
    , buildInputsFunc ? (pkgs: hsPkgs: [ ])
    , compiler ? "ghc884"
    , ...
    }:
    let
      hsPkgs = pkgs.haskell.packages."${compiler}";
      drv = hsPkgs.callCabal2nix "haskell" src { };
      watch-tests = pkgs.writeScriptBin "watch-tests" ''
        ${hsPkgs.ghcid.bin}/bin/ghcid --clear --command "cabal repl path-hs:test:tests" --test "hspec spec" --setup "import Test.Hspec"
      '';
    in
    {
      app = drv;
      shell = hsPkgs.shellFor {
        withHoogle = true;
        packages = _: [ drv ];
        buildInputs = with pkgs; [
          watch-tests
          cabal-install
          hsPkgs.ghcide
          hsPkgs.hspec-discover
        ] ++ (buildInputsFunc pkgs hsPkgs);
      };
    };
}
