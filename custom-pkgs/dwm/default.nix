{ stdenv, fetchFromGitHub
, pkg-config
, gnumake
, xorg
, pango
, yajl
}:
stdenv.mkDerivation {
  pname = "dwm";
  version = "6.5";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "dwm-6.5";
    rev = "eca163ad91cb5c58c804f2a3f81d7e5a41ae838b";
    sha256 = "sha256-6JHw+I5zyz8zJuV6Osmqc2MbU0q9JUhpMzNbiqnHqfI=";
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

