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
,wlroots_0_19
,tllist
,fcft
,libdrm
,dbus
}:
stdenv.mkDerivation {
  pname = "dwl";
  version = "0.8-dev";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWL";
    rev = "b30e1242993c2bca8284ea250731a995bf19e860";
    sha256 = "sha256-PuEl6uVM3GLiIUbcr2c3X+sxRz+Gys5qSe4HWQbr7eM=";
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
    wlroots_0_19
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

