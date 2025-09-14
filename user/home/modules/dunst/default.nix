{ config, pkgs, ... }:

let
  wofi = "${pkgs.wofi}/bin/wofi";
  xdg-open = "${pkgs.xdg-utils}/bin/xdg-open";
in
{
  # home.file.".config/dunst/dunstrc".source = ./dunstrc;
  # home.packages = [
  #   pkgs.dunst 
  # ];

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      size = "32x32";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 350;
        height = 500;
        origin = "top-right";
        offset = "0x20";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        icon_corner_radius = 0;
        indicate_hidden = true;
        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 3;
        frame_color = "#eceff4";
        gap_size = 0;
        separator_color = "frame";
        sort = true;
        font = "Hack Nerd Font 12";
        line_height = 0;
        markup = "full";
        format = "<b>[%a] %s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        icon_position = "left";
        sticky_history = true;
        history_length = 20;
        dmenu = "${wofi} --show dmenu";
        browser = "${xdg-open}";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 0;
        ignore_dbusclose = false;
        force_xwayland = false;
        force_xinerama = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "do_action, close_current";
      };
      experimental = {
        per_monitor_dpi = false;
      };
      urgency_low = {
        background = "#5e81ac";
        foreground = "#eceff4";
        highlight = "#eceff4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#5e81ac";
        foreground = "#eceff4";
        highlight = "#eceff4";
        timeout = 10;
      };
      urgency_critical = {
        background = "#bf616a";
        foreground = "#eceff4";
        frame_color = "#eceff4";
        highlight = "#eceff4";
        timeout = 0;
      };
      history_ignore = {
        appname = "ChangeVolume";
        history_ignore = true;
      };
    };
  };
}
