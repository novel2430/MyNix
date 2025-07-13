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
    rev = "f389dd8e9450057186ec41c04df09e9692f2955d";
    sha256 = "sha256-pk/7XYFEUw4gUf+fMjILxIn29pzA7Gpl1jzaquAcd5k=";
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

