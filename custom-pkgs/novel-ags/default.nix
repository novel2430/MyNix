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
    rev = "94176c1c3e358ac4b22232fb0ca8e6d205b2dd9f";
    sha256 = "sha256-MqKy8LYXveRfAW2vAIbxOyHMxg8nRm+WQr6BuIHO6GY=";
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

