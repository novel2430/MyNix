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
    rev = "16ae6b09bbbef9617a3c40bbc3ab6d84eeb7b750";
    sha256 = "sha256-Xs5fwPskn03Ffc8y6aXKNCnFGa9jSxHyUvB8DepVp/0=";
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
    ags bundle $src/app.ts novel-ags
    runHook postBuild

  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib

    install -Dm555 novel-ags $out/lib/novel-ags
    echo "${ags}/bin/ags run $out/lib/novel-ags" > $out/bin/novel-ags
    chmod +x $out/bin/novel-ags

    runHook postInstall
  '';
}

