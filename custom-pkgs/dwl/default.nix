{
stdenv, fetchFromGitHub
,gnumake
,libinput
,libxcb
,libxkbcommon
,pixman
,wayland
,wayland-protocols
,wayland-scanner
,libX11
,xcbutilwm
,xwayland
,pkg-config
,wlroots
,tllist
,fcft
,libdrm
,dbus
,python3
}:
stdenv.mkDerivation rec {
  pname = "dwl";
  version = "0.7";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWL";
    rev = "c4ea56ac130496f77ac0d785cbb5b0e15771f4c8";
    sha256 = "sha256-bDt8thYF1EpUmLTLsI0K49KbgFJ9kcAfx2RHIk6bgs8=";
  };

  nativeBuildInputs = [
    pkg-config
    gnumake
  ];

  buildInputs = [
    libinput
    libxcb
    libxkbcommon
    pixman
    wayland
    wayland-protocols
    wayland-scanner
    libX11
    xcbutilwm
    xwayland
    wlroots
    tllist
    fcft
    libdrm
    dbus
  ];

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib

    install -Dm555 dwl $out/lib/dwl
    install -Dm555 info.py $out/lib/info.py
    echo "${python3}/bin/python $out/lib/info.py | $out/lib/dwl" > $out/bin/dwl
    chmod +x $out/bin/dwl

    runHook postInstall
  '';
}

