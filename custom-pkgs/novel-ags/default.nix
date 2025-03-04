{
stdenvNoCC
, fetchFromGitHub
, makeWrapper
, wrapGAppsHook
, gobject-introspection
, astal
, ags 
}:
stdenvNoCC.mkDerivation rec {
  pname = "novel-ags";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "MyAGS";
    rev = "39fb7f86f79de21ccb9144479731d0760a1b6350";
    sha256 = "sha256-v7Lduh18CYw4SoYw75ZdnhNNJWWX914scEneQSieNsU=";
  };

  nativeBuildInputs = [
    ags
    wrapGAppsHook
    gobject-introspection
    makeWrapper
  ];

  buildInputs = with astal; [
    astal3
    io
    auth
    battery
    mpris
    notifd
    river
    tray
    wireplumber
    network
  ];

  buildPhase = ''
    runHook preBuild
    ags bundle $src/app.ts bar 
    runHook postBuild

  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib
    install -Dm555 bar $out/lib/bar
    echo "${ags}/bin/ags run $out/lib/bar" > $out/bin/novel-ags-bar
    chmod +x $out/bin/novel-ags-bar

    runHook postInstall
  '';
}

