{ inputs, ...}:
{
  #MimeType
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["mpv.desktop" "vlc.desktop"];
      "video/mpeg" = ["mpv.desktop" "vlc.desktop"];
      "video/quicktime" = ["mpv.desktop" "vlc.desktop"];
      "video/x-m4v" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-wmv" = ["mpv.desktop" "vlc.desktop"];
      "video/x-msvideo" = ["mpv.desktop" "vlc.desktop"];
      "video/webm" = ["mpv.desktop" "vlc.desktop"];
      "video/x-flv" = ["mpv.desktop" "vlc.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "audio/vnd.wave" = ["mpv.desktop" "vlc.desktop"];
      "audio/mpeg" = ["mpv.desktop" "vlc.desktop"];
      "audio/flac" = ["mpv.desktop" "vlc.desktop"];
      "audio/x-wav" = ["mpv.desktop" "vlc.desktop"];
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
      "video/mpeg" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "video/x-m4v" = ["mpv.desktop"];
      "video/x-ms-wmv" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/x-flv" = ["mpv.desktop"];
      "text/plain" = ["org.gnome.gedit.desktop"];
      "audio/vnd.wave" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/x-wav" = ["mpv.desktop"];
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
