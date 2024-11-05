{ pkgs, ... }:
let
  my-openttd = pkgs.openttd.overrideAttrs (final: prev : with pkgs; rec {
    pname = "openttd";
    version = "14.1";
    src = fetchurl {
      url = "https://cdn.openttd.org/openttd-releases/${final.version}/${final.pname}-${final.version}-source.tar.xz";
      hash = "sha256-LBTI8B9EFIxPLIjBaaMKvNsALrEoqSua23a6p2sBNJQ=";
    };
  });
in
{
  # home.packages = [
  #   my-openttd
  # ];
  openttd = my-openttd;
}
