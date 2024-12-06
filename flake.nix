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
              rev = "v2.0.1";
              sha256 = "sha256-/gCg1mJ4BDmgZ+jdWvns9CkhymWP3jdTqS7Z4n4zsO8=";
            };
            cargoDeps = old.cargoDeps.overrideAttrs {
              inherit src;
              outputHash = "sha256-dl1j+Wz5j/QO0HtCRss0IkjItnzhuB5D069a9s6Xarg=";
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
            tokei
            nodePackages.prettier
          ];
        };
      }
    );
}
