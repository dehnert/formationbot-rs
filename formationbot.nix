{ stdenv, lib, rustPlatform, pkg-config, pango, gdk-pixbuf, glib, cairo, libxml2 }:

let
  pkgs = import <nixpkgs> {};
  fs = lib.fileset;
in rustPlatform.buildRustPackage rec {
  pname = "formationbot-rs";
  version = "1.0";

  src = fs.toSource {
    #root = ./discord-bot;
    #fileset = fs.intersection ./discord-bot (fs.gitTracked ./.);
    root = ./.;
    fileset = (fs.gitTracked ./.);
  };
  sourceRoot = "source/discord-bot";

  cargoLock = {
    lockFile = ./discord-bot/Cargo.lock;
    outputHashes = {
      # Can use lib.fakeHash to find these
      "librsvg-2.55.90" = "sha256-fYXpjymasMvWMBbpQWqHHQmVwJIH+zmydK+6vdFzXLQ=";
    };
  };

  cargoHash = "sha256-jtBw4ahSl88L0iuCXxQgZVm1EcboWRJMNtjxLVTtzts=";

  meta = with lib; {
    description = "FormationBot renders square dance formations as pictures, to aid discussions of calling";
    homepage = "https://github.com/zyxw59/formationbot-rs";
    platforms = platforms.linux;
  };

  buildInputs = [
    pango
    gdk-pixbuf
    glib
    cairo
    libxml2
  ];
  nativeBuildInputs = [
  #  cargo
    pkg-config
  ];

  # Disabled because of https://github.com/zyxw59/formationbot-rs/issues/8
  doCheck = false;
}
