# emacs29-pgtk-xwidgets-webkit41.nix
{ pkgs, ...}:

let
  lib = pkgs.lib;

  version = "29.4";
  rev = "emacs-29.4";

  src = pkgs.fetchzip {
    url = "mirror://gnu/emacs/${rev}.tar.xz";
    # 你需要填真实 hash（见文末）
    hash = "sha256-p4jFYnpWdq7op8VqMpvEgdXNkqpyxznli5q6K1TEohk=";
  };

  siteStart = pkgs.writeText "site-start.el" ''
    ;; Minimal site-start for Nix-built Emacs.
    ;; Keep empty on purpose.
  '';

  # knobs (你可以在此改成 false 做快速兜底)
  withNativeCompilation = false;
  withDbus = pkgs.stdenv.hostPlatform.isLinux;
  withSystemd = lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.systemd;
  withSelinux = pkgs.stdenv.hostPlatform.isLinux;
  withMailutils = true;
  withSQLite3 = true;
  withTreeSitter = true;
  withWebP = true;
  withGlibNetworking = true;
  withToolkitScrollBars = true;
  withCompressInstall = true;

in

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "emacs-29-pgtk-xwidgets-webkit41";
  inherit version src;

  # ---- build tools ----
  nativeBuildInputs = [
    pkgs.pkg-config
    pkgs.makeWrapper
    pkgs.wrapGAppsHook3
    pkgs.texinfo
  ];

  # ---- libs ----
  buildInputs =
    [
      pkgs.gettext
      pkgs.gnutls
      (lib.getDev pkgs.harfbuzz)
      pkgs.libxml2
      pkgs.ncurses

      # PGTK runtime stack
      pkgs.gtk3
      pkgs.gsettings-desktop-schemas
    ]
    ++ lib.optionals withGlibNetworking [
      pkgs.glib-networking
    ]
    ++ lib.optionals withDbus [
      pkgs.dbus
    ]
    ++ lib.optionals withSelinux [
      pkgs.libselinux
    ]
    ++ lib.optionals withSQLite3 [
      pkgs.sqlite
    ]
    ++ lib.optionals withSystemd [
      pkgs.systemd
    ]
    ++ lib.optionals withTreeSitter [
      pkgs.tree-sitter
    ]
    ++ lib.optionals withWebP [
      pkgs.libwebp
    ]
    ++ [
      # common image libs (很接近官方 pgtk 组合)
      pkgs.giflib
      pkgs.libjpeg
      pkgs.libpng
      pkgs.librsvg
      pkgs.libtiff
      pkgs.libxpm
    ]
    ++ [
      # xwidgets on Linux needs WebKitGTK — 强制 4.1
      pkgs.webkitgtk_4_1
    ]
    ++ lib.optionals withNativeCompilation [
      pkgs.libgccjit
      pkgs.zlib
    ];

  # movemail runtime
  propagatedUserEnvPkgs = lib.optionals withMailutils [
    pkgs.mailutils
  ];

  # ---- patches / fixups (尽量贴近官方行为) ----
  postPatch = lib.concatStringsSep "\n" [
    # release tarball 中可能带 elc/loaddefs，nix build 里去掉更稳
    ''
      find . -type f \( -name "*.elc" -o -name "*loaddefs.el" \) -exec rm -f {} \; || true
    ''

    # tramp gvfs: 增加 wrapped gvfsd 名称（和官方一致的思路）
    ''
      for fn in tramp-compat-process-running-p tramp-process-running-p; do
        sed -i 's#('"$fn"' "gvfs-fuse-daemon")#('"$fn"' "gvfs-fuse-daemon") ('"$fn"' ".gvfsd-fuse-wrapped")#' lisp/net/tramp-gvfs.el || true
      done
    ''

    # 缩小 closure：让 dump 用干净环境跑 temacs（官方同款）
    ''
      substituteInPlace src/Makefile.in \
        --replace 'RUN_TEMACS = ./temacs' 'RUN_TEMACS = env -i ./temacs'
    ''

    # locale path / pwd path（官方同款）
    ''
      substituteInPlace lisp/international/mule-cmds.el \
        --replace /usr/share/locale ${pkgs.gettext}/share/locale || true

      for makefile_in in $(find . -name Makefile.in -print); do
        substituteInPlace "$makefile_in" --replace /bin/pwd pwd || true
      done
    ''

    # mailcap path（官方同款）
    ''
      substituteInPlace lisp/net/mailcap.el \
        --replace-fail '"/etc/mime.types"' \
                       '"/etc/mime.types" "${pkgs.mailcap}/etc/mime.types"' \
        --replace-fail '("/etc/mailcap" system)' \
                       '("/etc/mailcap" system) ("${pkgs.mailcap}/etc/mailcap" system)' || true
    ''
  ];

  hardeningDisable = [ "format" ];
  enableParallelBuilding = true;

  # ---- configure ----
  configureFlags =
    [
      (lib.enableFeature false "build-details")
      (lib.withFeature true "modules")

      # GUI stack: pgtk
      (lib.withFeature true "pgtk")

      # your target
      (lib.withFeature true "xwidgets")

      (lib.withFeature withCompressInstall "compress-install")
      (lib.withFeature withToolkitScrollBars "toolkit-scroll-bars")

      (lib.withFeature withNativeCompilation "native-compilation")

      (lib.withFeature withMailutils "mailutils")
      (lib.withFeature withTreeSitter "tree-sitter")
      (lib.withFeature withSQLite3 "sqlite3")
      (lib.withFeature withDbus "dbus")
      (lib.withFeature withSelinux "selinux")
    ];

  env =
    lib.optionalAttrs withNativeCompilation {
      NATIVE_FULL_AOT = "1";
      # 这比官方 driver-options patch 弱一些，但很多机器够用
      LIBRARY_PATH = lib.concatStringsSep ":" [
        "${lib.getLib pkgs.libgccjit}/lib/gcc"
        "${lib.getLib pkgs.stdenv.cc.libc}/lib"
      ];
    };

  installTargets = [ "tags" "install" ];

  postInstall =
    ''
      # site-start
      mkdir -p $out/share/emacs/site-lisp
      cp ${siteStart} $out/share/emacs/site-lisp/site-start.el
      $out/bin/emacs --batch -f batch-byte-compile $out/share/emacs/site-lisp/site-start.el || true

      # remove site-lisp in version dir (官方同款意图：避免重复/污染)
      siteVersionDir="$(ls $out/share/emacs | grep -v site-lisp | head -n 1)"
      rm -rf "$out/share/emacs/$siteVersionDir/site-lisp" || true

      # ship C sources (接近官方 withCsrc=true 的效果)
      for srcdir in src lisp lwlib ; do
        dstdir="$out/share/emacs/$siteVersionDir/$srcdir"
        mkdir -p "$dstdir"
        find "$srcdir" -name "*.[chm]" -exec cp {} "$dstdir" \; || true
        cp "$srcdir/TAGS" "$dstdir" || true
        echo '((nil . ((tags-file-name . "TAGS"))))' > "$dstdir/.dir-locals.el"
      done
    ''
    + lib.optionalString withNativeCompilation ''
      echo "Generating native-compiled trampolines..."
      $out/bin/emacs --batch --eval "(mapatoms (lambda (s) \
        (when (subr-primitive-p (symbol-function s)) (print s))))" \
        | xargs -n $((1000/NIX_BUILD_CORES + 1)) -P $NIX_BUILD_CORES \
          $out/bin/emacs --batch -l comp --eval "(while argv \
            (comp-trampoline-compile (intern (pop argv))))" || true

      mkdir -p $out/share/emacs/native-lisp
      $out/bin/emacs --batch \
        --eval "(add-to-list 'native-comp-eln-load-path \"$out/share/emacs/native-lisp\")" \
        -f batch-native-compile $out/share/emacs/site-lisp/site-start.el || true
    '';

  postFixup = ''
    # wrapGAppsHook3 会包一层；这里再追加 WebKit/GTK 的兜底变量
    wrapProgram "$out/bin/emacs" \
      --set-default GDK_GL disable \
      --set-default WEBKIT_DISABLE_COMPOSITING_MODE 1

    # 可选：如果你也用 emacsclient
    if [ -x "$out/bin/emacsclient" ]; then
      wrapProgram "$out/bin/emacsclient" \
        --set-default GDK_GL disable \
        --set-default WEBKIT_DISABLE_COMPOSITING_MODE 1
    fi
  '';

  passthru = {
    inherit withNativeCompilation;
    withXwidgets = true;
    withPgtk = true;
  };

  meta = with lib; {
    description = "GNU Emacs 29.4 (PGTK + xwidgets, forced WebKitGTK 4.1) – standalone derivation";
    homepage = "https://www.gnu.org/software/emacs/";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "emacs";
  };
})
