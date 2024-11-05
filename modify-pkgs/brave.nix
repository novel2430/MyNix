{ pkgs, nix23-pkgs, ... }:
let
  lib = pkgs.lib;

  gtk-4-12-5 = nix23-pkgs.gtk4.overrideAttrs (final: prev : with pkgs; rec {
    version = "4.12.5";
    src = fetchurl {
      url = "mirror://gnome/sources/gtk/${lib.versions.majorMinor final.version}/gtk-${final.version}.tar.xz";
      hash = "sha256-KLNW1ZDuaO9ibi75ggst0hRBSEqaBCpaPwxA6d/E9Pg=";
    };
  });

  deps = with pkgs; [
    alsa-lib at-spi2-atk at-spi2-core atk cairo cups dbus expat
    fontconfig freetype gdk-pixbuf glib gtk3 gtk-4-12-5 libdrm xorg.libX11 libGL
    libxkbcommon xorg.libXScrnSaver xorg.libXcomposite xorg.libXcursor xorg.libXdamage
    xorg.libXext xorg.libXfixes xorg.libXi xorg.libXrandr xorg.libXrender xorg.libxshmfence
    xorg.libXtst libuuid mesa nspr nss pango pipewire udev wayland
    xorg.libxcb zlib snappy libkrb5
  ];
  rpath = lib.makeLibraryPath deps + ":" + lib.makeSearchPathOutput "lib" "lib64" deps;
  binpath = lib.makeBinPath deps;

  # enableFeatures = lib.optionals lib.enableVideoAcceleration [ "VaapiVideoDecoder" "VaapiVideoEncoder" ]
  #   ++ lib.optional lib.enableVulkan "Vulkan";
  enableFeatures = [];

  disableFeatures = [ "OutdatedBuildDetector" ] # disable automatic updates
    # The feature disable is needed for VAAPI to work correctly: https://github.com/brave/brave-browser/issues/20935
    # ++ lib.optionals lib.enableVideoAcceleration  [ "UseChromeOSDirectVideoDecoder" ]
    ;

  new-installPhase = with pkgs; ''
      runHook preInstall

      mkdir -p $out $out/bin

      cp -R usr/share $out
      cp -R opt/ $out/opt

      export BINARYWRAPPER=$out/opt/brave.com/brave/brave-browser

      # Fix path to bash in $BINARYWRAPPER
      substituteInPlace $BINARYWRAPPER \
          --replace /bin/bash ${stdenv.shell}

      ln -sf $BINARYWRAPPER $out/bin/brave

      for exe in $out/opt/brave.com/brave/{brave,chrome_crashpad_handler}; do
          patchelf \
              --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${rpath}" $exe
      done

      # Fix paths
      substituteInPlace $out/share/applications/brave-browser.desktop \
          --replace /usr/bin/brave-browser-stable $out/bin/brave
      substituteInPlace $out/share/gnome-control-center/default-apps/brave-browser.xml \
          --replace /opt/brave.com $out/opt/brave.com
      substituteInPlace $out/share/menu/brave-browser.menu \
          --replace /opt/brave.com $out/opt/brave.com
      substituteInPlace $out/opt/brave.com/brave/default-app-block \
          --replace /opt/brave.com $out/opt/brave.com

      # Correct icons location
      icon_sizes=("16" "24" "32" "48" "64" "128" "256")

      for icon in ''${icon_sizes[*]}
      do
          mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
          ln -s $out/opt/brave.com/brave/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/brave-browser.png
      done

      # Replace xdg-settings and xdg-mime
      ln -sf ${xdg-utils}/bin/xdg-settings $out/opt/brave.com/brave/xdg-settings
      ln -sf ${xdg-utils}/bin/xdg-mime $out/opt/brave.com/brave/xdg-mime

      runHook postInstall
  '';

  new-preFixup = with pkgs; with lib; ''
    # Add command line args to wrapGApp.
    gappsWrapperArgs+=(
      --prefix LD_LIBRARY_PATH : ${rpath}
      --prefix PATH : ${binpath}
      --suffix PATH : ${lib.makeBinPath [ xdg-utils coreutils ]}
      ${optionalString (enableFeatures != []) ''
      --add-flags "--enable-features=${strings.concatStringsSep "," enableFeatures}\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+,WaylandWindowDecorations}}"
      ''}
      ${optionalString (disableFeatures != []) ''
      --add-flags "--disable-features=${strings.concatStringsSep "," disableFeatures}"
      ''}
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto}}"
    )
  '';

  my-brave = pkgs.brave.overrideAttrs (final: prev : with pkgs; rec {
    buildInputs = [
      # needed for GSETTINGS_SCHEMAS_PATH
      glib gsettings-desktop-schemas gtk3 gtk-4-12-5
      # needed for XDG_ICON_DIRS
      gnome.adwaita-icon-theme
    ];
    installPhase = "${new-installPhase}";
    preFixup = "${new-preFixup}";
  });
in
{
  brave = my-brave;
}
