{ pkgs, ... }:
{
  mkRustApp = {
    src
    , buildInputsFunc ? (pkgs: [])
    , ...
  }: {
    shell = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.cargo
        pkgs.rustc
      ] ++ (buildInputsFunc pkgs);
    };
  };
}
