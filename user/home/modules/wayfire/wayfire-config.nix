{lib, opt-config, pkgs, ...}:
with lib;
let
  wayfire-config = {
    alpha = {
      min_value = "0.100000";
      modifier = "<alt> <super>";
    };
    animate = {
      close_animation = "zoom";
      duration = "300";
      enabled_for = ''(type equals "toplevel" | (type equals "x-or" & focusable equals true))'';
      fade_duration = "300";
      fade_enabled_for = ''type equals "overlay"'';
      fire_color = "\\#B22303FF";
      fire_duration = "300";
      fire_enabled_for = "none";
      fire_particle_size = "16.000000";
      fire_particles = "2000";
      open_animation = "zoom";
      random_fire_color = "false";
      startup_duration = "300";
      zoom_duration = "300";
      zoom_enabled_for = "none";
    };
    autostart = {
      autostart_wf_shell = "false";
      gamma = "wlsunset";
      idle = "my-swayidle";
      my_autostart = "my-wf-autostart";
      outputs = "kanshi";
    };
    blur = {
      blur_by_default = ''type is "toplevel"'';
      bokeh_degrade = "1";
      bokeh_iterations = "15";
      bokeh_offset = "5.000000";
      box_degrade = "1";
      box_iterations = "2";
      box_offset = "1.000000";
      gaussian_degrade = "1";
      gaussian_iterations = "2";
      gaussian_offset = "1.000000";
      kawase_degrade = "3";
      kawase_iterations = "2";
      kawase_offset = "1.700000";
      method = "kawase";
      saturation = "1.000000";
      toggle = "none";
    };
    command = {
      binding_clipboard = "<super> KEY_C";
      binding_launcher = "<super> KEY_D";
      binding_lock = "<super> <shift> KEY_L";
      binding_mute = "KEY_MUTE";
      binding_run_launcher = "<super> KEY_R";
      binding_screenshot = "KEY_SYSRQ";
      binding_screenshot_interactive = "<super> KEY_SYSRQ";
      binding_terminal = "<super> KEY_ENTER";
      binding_web_browser = "<super> <shift> KEY_F";
      binding_waybar = "<super> <shift> KEY_B";
      binding_light_up = "KEY_BRIGHTNESSUP";
      binding_light_down = "KEY_BRIGHTNESSDOWN";
      binding_power_menu = "<super> <shift> KEY_P";
      command_clipboard = "wlroot-clipboard";
      command_launcher = "wofi --show drun";
      command_lock = "my-swaylock manual";
      command_mute = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      command_run_launcher = "wofi --show run";
      command_screenshot = "grim-slurp-screenshot full";
      command_screenshot_interactive = "grim-slurp-screenshot select";
      command_terminal = "foot";
      command_volume_down = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-";
      command_volume_up = "${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
      command_light_up = "brightnessctl set 10%+";
      command_light_down = "brightnessctl set 10%-";
      command_web_browser = "brave -enable-features=UseOzonePlatform -ozone-platform=wayland --gtk-version=4";
      command_waybar = "killall waybar; ~/.config/wayfire/bar-run.sh";
      command_power_menu = "wofi-power-menu";
      repeatable_binding_volume_down = "KEY_VOLUMEDOWN";
      repeatable_binding_volume_up = "KEY_VOLUMEUP";
    };
    core = {
      background_color = "\\#1A1A1AFF";
      close_top_view = "<super> KEY_Q | <alt> KEY_F4";
      focus_button_with_modifiers = "false";
      focus_buttons = "BTN_LEFT | BTN_MIDDLE | BTN_RIGHT";
      focus_buttons_passthrough = "true";
      max_render_time = "-1";
      plugins = "alpha   animate   autostart   command   cube   decoration   expo   fast-switcher   fisheye   foreign-toplevel   grid   gtk-shell   idle   invert   move   oswitch   place   resize   switcher   vswitch   wayfire-shell   window-rules   wm-actions   wobbly   wrot   input-method-v1   zoom scale";
      preferred_decoration_mode = "client";
      transaction_timeout = "100";
      vheight = "3";
      vwidth = "3";
      xwayland = "true";
    };
    cube = {
      activate = "<alt> <ctrl> BTN_LEFT";
      background = "\\#1A1A1AFF";
      background_mode = "simple";
      cubemap_image = "";
      deform = "0";
      initial_animation = "350";
      light = "true";
      rotate_left = "none";
      rotate_right = "none";
      skydome_mirror = "true";
      skydome_texture = "";
      speed_spin_horiz = "0.020000";
      speed_spin_vert = "0.020000";
      speed_zoom = "0.070000";
      zoom = "0.100000";
    };
    decoration = {
      active_color = "\\#637c8cFF";
      border_size = "2";
      button_order = "minimize maximize close";
      font = "Hack Nerd Font";
      ignore_views = "none";
      inactive_color = "\\#1c2e36FF";
      title_height = "25";
    };
    expo = {
      background = "\\#375566FF";
      duration = "300";
      inactive_brightness = "0.700000";
      keyboard_interaction = "true";
      offset = "10";
      select_workspace_1 = "KEY_1";
      select_workspace_2 = "KEY_2";
      select_workspace_3 = "KEY_3";
      select_workspace_4 = "KEY_4";
      select_workspace_5 = "KEY_5";
      select_workspace_6 = "KEY_6";
      select_workspace_7 = "KEY_7";
      select_workspace_8 = "KEY_8";
      select_workspace_9 = "KEY_9";
      toggle = "<super>";
      transition_length = "200";
    };
    extra-gestures = {
      close_fingers = "20";
      move_delay = "500";
      move_fingers = "3";
    };
    fast-switcher = {
      activate = "<super> KEY_J";
      activate_backward = "<super> KEY_K";
    };
    fisheye = {
      radius = "450.000000";
      toggle = "<ctrl> <super> KEY_F";
      zoom = "7.000000";
    };
    grid = {
      duration = "300";
      restore = "<super> KEY_DOWN | <super> KEY_KP0";
      slot_b = "<super> KEY_KP2";
      slot_bl = "<super> KEY_KP1";
      slot_br = "<super> KEY_KP3";
      slot_c = "<super> KEY_UP | <super> KEY_KP5";
      slot_l = "<super> KEY_LEFT | <super> KEY_KP4";
      slot_r = "<super> KEY_RIGHT | <super> KEY_KP6";
      slot_t = "<super> KEY_KP8";
      slot_tl = "<super> KEY_KP7";
      slot_tr = "<super> KEY_KP9";
      type = "crossfade";
    };
    idle = {
      cube_max_zoom = "1.500000";
      cube_rotate_speed = "1.000000";
      cube_zoom_speed = "1000";
      disable_initially = "false";
      disable_on_fullscreen = "true";
      dpms_timeout = "-1";
      screensaver_timeout = "3600";
      toggle = "none";
    };
    input = {
      click_method = "default";
      cursor_size = "15";
      cursor_theme = "default";
      disable_touchpad_while_mouse = "false";
      disable_touchpad_while_typing = "false";
      drag_lock = "false";
      gesture_sensitivity = "1.000000";
      kb_capslock_default_state = "false";
      kb_numlock_default_state = "false";
      kb_repeat_delay = "300";
      kb_repeat_rate = "50";
      left_handed_mode = "false";
      middle_emulation = "false";
      modifier_binding_timeout = "400";
      mouse_accel_profile = "default";
      mouse_cursor_speed = "0.000000";
      mouse_scroll_speed = "1.000000";
      natural_scroll = "false";
      scroll_method = "default";
      tablet_motion_mode = "default";
      tap_to_click = "true";
      touchpad_accel_profile = "default";
      touchpad_cursor_speed = "0.000000";
      touchpad_scroll_speed = "1.000000";
      xkb_layout = "us";
      xkb_model = "";
      xkb_options = "";
      xkb_rules = "evdev";
      xkb_variant = "";
    };
    input-device = {
      output = "";
    };
    invert = {
      preserve_hue = "false";
      toggle = "<super> KEY_I";
    };
    move = {
      activate = "<super> BTN_LEFT";
      enable_snap = "true";
      enable_snap_off = "true";
      join_views = "false";
      preview_base_border = "\\#404080CC";
      preview_base_color = "\\#8080FF80";
      preview_border_width = "3";
      quarter_snap_threshold = "50";
      snap_off_threshold = "10";
      snap_threshold = "10";
      workspace_switch_after = "-1";
    };
    oswitch = {
      next_output = "<super> KEY_O";
      next_output_with_win = "<shift> <super> KEY_O";
      prev_output = "";
      prev_output_with_win = "";
    };
    output = {
      depth = "8";
      mode = "auto";
      position = "auto";
      scale = "1.0";
      transform = "normal";
      vrr = "false";
    };
    place = {
      mode = "center";
    };
    preserve-output = {
      last_output_focus_timeout = "10000";
    };
    resize = {
      activate = "<super> BTN_RIGHT";
      activate_preserve_aspect = "none";
    };
    scale = {
      allow_zoom = "false";
      bg_color = "\\#1A1A1AE6";
      duration = "300";
      inactive_alpha = "0.750000";
      include_minimized = "true";
      middle_click_close = "false";
      minimized_alpha = "0.450000";
      outer_margin = "0";
      spacing = "30";
      text_color = "\\#CCCCCCFF";
      title_font_size = "20";
      title_overlay = "all";
      title_position = "center";
      toggle = "<alt> KEY_SPACE | hotspot right-top 10x10 250";
      toggle_all = "";
    };
    switcher = {
      next_view = "<alt> KEY_TAB";
      prev_view = "<alt> <shift> KEY_TAB";
      speed = "200";
      view_thumbnail_rotation = "30";
      view_thumbnail_scale = "1.000000";
    };
    vswipe = {
      background = "\\#1A1A1AFF";
      delta_threshold = "24.000000";
      duration = "180";
      enable_free_movement = "false";
      enable_horizontal = "true";
      enable_smooth_transition = "false";
      enable_vertical = "true";
      fingers = "4";
      gap = "32.000000";
      speed_cap = "0.050000";
      speed_factor = "256.000000";
      threshold = "0.350000";
    };
    vswitch = {
      background = "\\#1A1A1AFF";
      binding_down = "<ctrl> <super> KEY_DOWN";
      binding_last = "";
      binding_left = "<ctrl> <super> KEY_LEFT";
      binding_right = "<ctrl> <super> KEY_RIGHT";
      binding_up = "<ctrl> <super> KEY_UP";
      duration = "300";
      gap = "20";
      send_win_down = "";
      send_win_last = "";
      send_win_left = "";
      send_win_right = "";
      send_win_up = "";
      with_win_down = "<ctrl> <shift> <super> KEY_DOWN";
      with_win_last = "";
      with_win_left = "<ctrl> <shift> <super> KEY_LEFT";
      with_win_right = "<ctrl> <shift> <super> KEY_RIGHT";
      with_win_up = "<ctrl> <shift> <super> KEY_UP";
      wraparound = "false";
      binding_1 = "<super> KEY_1";
      binding_2 = "<super> KEY_2";
      binding_3 = "<super> KEY_3";
      binding_4 = "<super> KEY_4";
      binding_5 = "<super> KEY_5";
      binding_6 = "<super> KEY_6";
      binding_7 = "<super> KEY_7";
      binding_8 = "<super> KEY_8";
      binding_9 = "<super> KEY_9";
      send_win_1 = "<super> <shift> KEY_1";
      send_win_2 = "<super> <shift> KEY_2";
      send_win_3 = "<super> <shift> KEY_3";
      send_win_4 = "<super> <shift> KEY_4";
      send_win_5 = "<super> <shift> KEY_5";
      send_win_6 = "<super> <shift> KEY_6";
      send_win_7 = "<super> <shift> KEY_7";
      send_win_8 = "<super> <shift> KEY_8";
      send_win_9 = "<super> <shift> KEY_9";
    };
    wayfire-shell = {
      toggle_menu = "<super>";
    };
    wm-actions = {
      minimize = "none";
      send_to_back = "none";
      toggle_always_on_top = "<super> KEY_X";
      toggle_fullscreen = "<super> KEY_F";
      toggle_maximize = "none";
      toggle_showdesktop = "none";
      toggle_sticky = "none";
    };
    wobbly = {
      friction = "3.000000";
      grid_resolution = "6";
      spring_k = "8.000000";
    };
    workarounds = {
      all_dialogs_modal = "true";
      app_id_mode = "stock";
      discard_command_output = "true";
      dynamic_repaint_delay = "false";
      enable_input_method_v2 = "false";
      enable_so_unloading = "false";
      force_preferred_decoration_mode = "false";
      remove_output_limits = "false";
      use_external_output_configuration = "false";
    };
    wrot = {
      activate = "<ctrl> BTN_RIGHT";
      activate-3d = "<shift> <super> BTN_RIGHT";
      invert = "false";
      reset = "<ctrl> <super> KEY_R";
      reset-one = "<super> KEY_R";
      reset_radius = "25.000000";
      sensitivity = "24";
    };
    wsets = {
      label_duration = "2000";
    };
    zoom = {
      interpolation_method = "0";
      modifier = "<super>";
      smoothing_duration = "300";
      speed = "0.010000";
    };
  }
  //
  opt-config.monitors
  ;
in
{
  home.file.".config/wayfire.ini".text = 
  let
    renderSection = name: section:
      let
        renderOption = key: value: ''${key} = ${value}'';
      in
      "[${name}]\n" + (concatStringsSep "\n" (mapAttrsToList renderOption section));
  in
  concatStringsSep "\n\n" (mapAttrsToList renderSection wayfire-config);
}
