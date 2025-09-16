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
    rev = "e13e70ccc12045e0654963726bb3e1fc9c6cbb2f";
    sha256 = "sha256-Ch+kHMa9/hqwLtZxFSZi6kMn6STV+7pWEuWW/0Kq5BY=";
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

