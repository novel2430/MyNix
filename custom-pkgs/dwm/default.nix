{ stdenv, fetchFromGitHub
, pkg-config
, gnumake
, xorg
, pango
, yajl
}:
stdenv.mkDerivation {
  pname = "dwm";
  version = "6.6";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWM-6.6";
    rev = "49d0b98f3ec995741f333236511666344b1108db";
    sha256 = "sha256-lynfLoefphsb0QAPl1YSwcA7Ew4vIFjmtTVoTZvzqR4=";
  };

  nativeBuildInputs = [
    pkg-config
    gnumake
  ];

  buildInputs = with xorg; [
    pango
    yajl
    libX11
    libXft
    libXinerama
  ];

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    install -Dm555 dwm $out/bin/dwm
    install -Dm555 dwm-msg $out/bin/dwm-msg

    runHook postInstall
  '';
}

