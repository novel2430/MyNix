{
stdenv, fetchFromGitHub, writers
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
}:
let
  dwl-sys-info = import ./dwl-sys-info.nix {inherit writers;};
in
stdenv.mkDerivation {
  pname = "dwl";
  version = "0.7";
  src = fetchFromGitHub {
    owner = "novel2430";
    repo = "DWL-0.7";
    rev = "56474ed0f96b24ba2a18b78fc76749e5d798bf08";
    sha256 = "sha256-t/RkETBfDtoo6Knqeomrw+5bfa82yS7NbU1UvRWA+Mk=";
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

    install -Dm555 dwl $out/bin/dwl
    echo "${dwl-sys-info} | $out/bin/dwl -s 'my-dwl-autostart' " > $out/bin/dwl-all
    chmod +x $out/bin/dwl-all

    runHook postInstall
  '';
}

