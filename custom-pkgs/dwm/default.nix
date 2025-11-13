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
    rev = "c7a7ba9d677d7fd56fbba453b0e9aa6c60e59d5f";
    sha256 = "sha256-tkB44/ChS2i7YMYonj4GoaxTdTY5/g/rlCQkg2i+eN8=";
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

