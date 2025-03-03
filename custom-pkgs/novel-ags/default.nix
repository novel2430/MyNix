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
    rev = "91852ab9a330a46c6abdeb806fd1c14b09faf7bd";
    sha256 = "sha256-TY2TmKXcKxkTinaeLcQigH2C57rw8OlwKTYhp7Fi+6Q=";
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

