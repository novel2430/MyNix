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
    rev = "b6ec41491626995332136f999f2980f09bb338b0";
    sha256 = "sha256-rFnIOWcKeMH5Xi8sv5cweXVFbS9Pj2GI4O7F4eMeUSE=";
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

