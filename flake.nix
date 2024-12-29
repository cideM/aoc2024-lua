{
  description = "Advent of Code in Lua";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=36fcc808a13782146ab0549ad52c27551af5c49f";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        stylua-overlay = self: super: {
          stylua = super.stylua.overrideAttrs (old: rec {
            src = super.fetchFromGitHub {
              owner = "johnnymorganz";
              repo = "stylua";
              rev = "v2.0.2";
              sha256 = "sha256-sZrymo1RRfDLz8fPa7FnbutSpOCFoyQPoFVjA6BH5qQ=";
            };
            cargoDeps = old.cargoDeps.overrideAttrs {
              inherit src;
              outputHash = "sha256-slSIDHGm8lmuXR5eCxm4q86d2dwaNoZI7qihgXNgLZI=";
            };
          });
        };

        pkgs = import nixpkgs {
          inherit system;
          overlays = [stylua-overlay];
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            alejandra
            coreutils
            moreutils
            jq
            alejandra
            lua5_4
            stylua
            lua-language-server
            graphviz
            tokei
            nodePackages.prettier
          ];
        };
      }
    );
}
