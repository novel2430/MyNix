{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/http" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/https" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/about" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/unknown" = ["app.zen_browser.zen.desktop"];
      "audio/vnd.wave" = ["io.bassi.1mberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/flac" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/x-wav" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop" "app.zen_browser.zen.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-extension-htm" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-html" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-shtml" = ["app.zen_browser.zen.desktop"];
      "application/xhtml+xml" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-xhtml" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-xht" = ["app.zen_browser.zen.desktop"];
    };
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/http" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/https" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/about" = ["app.zen_browser.zen.desktop"];
      "x-scheme-handler/unknown" = ["app.zen_browser.zen.desktop"];
      "audio/vnd.wave" = ["io.bassi.Amberol.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop"];
      "audio/flac" = ["io.bassi.Amberol.desktop"];
      "audio/x-wav" = ["io.bassi.Amberol.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-extension-htm" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-html" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-shtml" = ["app.zen_browser.zen.desktop"];
      "application/xhtml+xml" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-xhtml" = ["app.zen_browser.zen.desktop"];
      "application/x-extension-xht" = ["app.zen_browser.zen.desktop"];
    };
  };

}
