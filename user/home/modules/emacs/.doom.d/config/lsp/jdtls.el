(after! lsp-java
  (setq lsp-java-java-path (getenv "EMACS_JAVA_21_PATH")
        lsp-java-server-install-dir (expand-file-name "~/.local/share/doomemacs/packages/jdtls")
        lsp-java-configuration-maven-user-settings (expand-file-name "~/.m2/settings.xml")
        lsp-java-vmargs
           `(
             "-Declipse.application=org.eclipse.jdt.ls.core.id1"
             "-Dosgi.bundles.defaultStartLevel=4"
             "-Declipse.product=org.eclipse.jdt.ls.core.product"
             "-Dosgi.sharedConfiguration.area.readOnly=true"
             "-XX:+UseParallelGC"
             "-XX:GCTimeRatio=4"
             "-XX:AdaptiveSizePolicyWeight=90"
             "-Dsun.zip.disableMemoryMapping=true"
             "-Xmx2G"
             "-Xms100m"
            )
        lsp-java-format-settings-url "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
        lsp-java-format-settings-profile "GoogleStyle"
        lsp-java-save-action-organize-imports t))

