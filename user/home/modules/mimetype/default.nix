{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["app.zen_browser.zen"];
      "x-scheme-handler/http" = ["app.zen_browser.zen"];
      "x-scheme-handler/https" = ["app.zen_browser.zen"];
      "x-scheme-handler/about" = ["app.zen_browser.zen"];
      "x-scheme-handler/unknown" = ["app.zen_browser.zen"];
      "audio/vnd.wave" = ["vlc.desktop" "mpv.desktop"];
      "audio/mpeg" = ["vlc.desktop" "mpv.desktop"];
      "audio/flac" = ["vlc.desktop" "mpv.desktop"];
      "audio/x-wav" = ["vlc.desktop" "mpv.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop" "app.zen_browser.zen"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "x-scheme-handler/chrome" = ["app.zen_browser.zen"];
      "application/x-extension-htm" = ["app.zen_browser.zen"];
      "application/x-extension-html" = ["app.zen_browser.zen"];
      "application/x-extension-shtml" = ["app.zen_browser.zen"];
      "application/xhtml+xml" = ["app.zen_browser.zen"];
      "application/x-extension-xhtml" = ["app.zen_browser.zen"];
      "application/x-extension-xht" = ["app.zen_browser.zen"];
    };
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["app.zen_browser.zen"];
      "x-scheme-handler/http" = ["app.zen_browser.zen"];
      "x-scheme-handler/https" = ["app.zen_browser.zen"];
      "x-scheme-handler/about" = ["app.zen_browser.zen"];
      "x-scheme-handler/unknown" = ["app.zen_browser.zen"];
      "audio/vnd.wave" = ["vlc.desktop"];
      "audio/mpeg" = ["vlc.desktop"];
      "audio/flac" = ["vlc.desktop"];
      "audio/x-wav" = ["vlc.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop" "app.zen_browser.zen"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "x-scheme-handler/chrome" = ["app.zen_browser.zen"];
      "application/x-extension-htm" = ["app.zen_browser.zen"];
      "application/x-extension-html" = ["app.zen_browser.zen"];
      "application/x-extension-shtml" = ["app.zen_browser.zen"];
      "application/xhtml+xml" = ["app.zen_browser.zen"];
      "application/x-extension-xhtml" = ["app.zen_browser.zen"];
      "application/x-extension-xht" = ["app.zen_browser.zen"];
    };
  };

}
