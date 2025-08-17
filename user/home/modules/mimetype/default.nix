{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "audio/vnd.wave" = ["io.bassi.1mberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/mpeg" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/flac" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/x-wav" = ["io.bassi.Amberol.desktop" "vlc.desktop" "mpv.desktop"];
      "audio/x-flac+ogg" = ["mpv.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop" "wps-office-pdf.desktop"];
      "image/png" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/jpeg" = ["com.github.weclaw1.ImageRoll.desktop"];
      "image/svg+xml" = ["com.github.weclaw1.ImageRoll.desktop"];
      "applications/zip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop" "xarchiver.desktop"];
    };
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
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
    };
  };

}
