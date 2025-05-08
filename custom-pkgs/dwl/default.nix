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
stdenv.mkDerivation {
  pname = "dwl";
  version = "0.7";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWL";
    rev = "d09c6a5d6e8617343205933105714e97cb1f7526";
    sha256 = "sha256-RCIaXfGQHdI9xs1n67ZIG9OBU4sGYv4uFdYrDbrSHfc=";
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

