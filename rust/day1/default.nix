{ p ? import ../.. }:
p.rust.helper.mkRustApp {
  src = ./.;
}
