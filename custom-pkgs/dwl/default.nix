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
,wlroots_0_18
,tllist
,fcft
,libdrm
,dbus
}:
stdenv.mkDerivation {
  pname = "dwl";
  version = "0.7";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWL-0.7";
    rev = "ea44868f4fd48e036506959228a0069ad6f055f2";
    sha256 = "sha256-TeVYFkIikyCLz/jQyG+QEHpRbrOjX5P+CIrDNuDpl8s=";
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
    tllist
    fcft
    libdrm
    dbus
    wlroots_0_18
  ];

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    install -Dm555 dwl $out/bin/dwl
    echo "$out/bin/dwl -s 'my-dwl-autostart' " > $out/bin/dwl-all
    chmod +x $out/bin/dwl-all

    runHook postInstall
  '';
}

