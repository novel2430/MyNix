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
    rev = "e065d6a2bb8d04786201eea1822be7b12ca230ad";
    sha256 = "sha256-l7Bp9D+siveN0yu/MM/OCdlSrdIlszm/eusYN9ZkQZ0=";
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

