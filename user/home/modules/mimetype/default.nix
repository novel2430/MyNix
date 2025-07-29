{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/http" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/https" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/about" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/unknown" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "audio/vnd.wave" = ["vlc.desktop" "mpv.desktop"];
      "audio/mpeg" = ["vlc.desktop" "mpv.desktop"];
      "audio/flac" = ["vlc.desktop" "mpv.desktop"];
      "audio/x-wav" = ["vlc.desktop" "mpv.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop" "userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "x-scheme-handler/chrome" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-htm" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-html" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-shtml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/xhtml+xml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-xhtml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-xht" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
    };
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/http" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/https" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/about" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "x-scheme-handler/unknown" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "audio/vnd.wave" = ["vlc.desktop"];
      "audio/mpeg" = ["vlc.desktop"];
      "audio/flac" = ["vlc.desktop"];
      "audio/x-wav" = ["vlc.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop" "userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "x-scheme-handler/chrome" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-htm" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-html" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-shtml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/xhtml+xml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-xhtml" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
      "application/x-extension-xht" = ["userapp-Zen-I55F72.desktop" "zen-browser-bin.desktop"];
    };
  };

}
