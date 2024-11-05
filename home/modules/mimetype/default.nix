{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["io.github.celluloid_player.Celluloid.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["brave-browser.desktop"];
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];
      "x-scheme-handler/about" = ["brave-browser.desktop"];
      "x-scheme-handler/unknown" = ["brave-browser.desktop"];
      "audio/vnd.wave" = ["io.bassi.Amberol.desktop" "io.github.celluloid_player.Celluloid.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop" "io.github.celluloid_player.Celluloid.desktop"];
      "audio/flac" = ["io.bassi.Amberol.desktop" "io.github.celluloid_player.Celluloid.desktop"];
      "audio/x-wav" = ["io.bassi.Amberol.desktop" "io.github.celluloid_player.Celluloid.desktop"];
      "audio/x-flac+ogg" = ["io.github.celluloid_player.Celluloid.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop"];
    };
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["io.github.celluloid_player.Celluloid.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "text/html" = ["brave-browser.desktop"];
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];
      "x-scheme-handler/about" = ["brave-browser.desktop"];
      "x-scheme-handler/unknown" = ["brave-browser.desktop"];
      "audio/vnd.wave" = ["io.bassi.Amberol.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop"];
      "audio/flac" = ["io.bassi.Amberol.desktop"];
      "audio/x-wav" = ["io.bassi.Amberol.desktop"];
      "audio/x-flac+ogg" = ["io.github.celluloid_player.Celluloid.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop"];
    };
  };

}
