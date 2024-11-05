{ pkgs, ... }:
let
  my-hmcl = pkgs.hmcl.overrideAttrs (final: prev : with pkgs; rec {
    pname = "hmcl";
    version = "3.5.7";
    src = fetchurl {
      url = "https://github.com/huanghongxun/HMCL/releases/download/release-${final.version}/HMCL-${final.version}.jar";
      hash = "sha256-ziqcauetWoFn58kBJ0KnqX5CPNC/Sn7DD/Buxdi977I=";
    };
  });
in
{
  hmcl = my-hmcl;
}
