{pkgs, opt-config, ...}:
{
  home.file.".config/hypr/waybar.jsonc".source = ./waybar.jsonc;
  home.file.".config/hypr/waybar.css".source = ./waybar.css;

  home.packages = [
    (import ./autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./waybar.nix {
      inherit pkgs;
    })
  ];

  imports = [
    ./toggle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = [
        "DISPLAY"
        "HYPRLAND_INSTANCE_SIGNATURE"
        "WAYLAND_DISPLAY"
        "XDG_CURRENT_DESKTOP"
      ];
    };
    settings = {
      "$mod" = "SUPER";
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, my-volume up"
        ", XF86AudioLowerVolume, exec, my-volume down"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, J, layoutmsg, cyclenext"
        "$mod, K, layoutmsg, cycleprev"
      ];
      bindl = [
        ", XF86AudioMute, exec, my-volume mute"
      ];
      bind = [
        "$mod, Return, exec, foot" 
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, D, exec, wofi --show drun"
        "$mod SHIFT, Return, layoutmsg, swapwithmaster"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod Ctrl, right, workspace, e+1"
        "$mod Ctrl, left, workspace, e-1"
        "$mod SHIFT, F, exec, brave --gtk-version=4 -enable-features=UseOzonePlatform -ozone-platform=wayland"
        "$mod SHIFT, L, exec, my-swaylock manual"
        " , Print, exec, my-screenshot full"
        "$mod, Print, exec, my-screenshot select"
        "$mod, Tab, exec, ~/.config/hypr/toggle.py"
        "$mod, C, exec, my-show-clipboard"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 0;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        repeat_rate = 25;
        repeat_delay = 250;
      };
      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;
        "col.active_border" = "rgba(eceff4ff)";
        "col.inactive_border" = "rgba(595959aa)";
      };
      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 0.6;
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      master = {
        new_status = "master";
        new_on_top = true;
      };
      env = [
        # "LIBVA_DRIVER_NAME,nvidia"
        # "XDG_SESSION_TYPE,wayland"
        # "GBM_BACKEND,nvidia-drm"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        # "WLR_NO_HARDWARE_CURSORS,1"
        # "GDK_BACKEND,wayland,x11"
      ];
      exec-once = [
        "my-hpyr-autostart"
      ];
      monitor = opt-config.hypr-monitors;
      windowrulev2 = [
        "float,class:(org.jackhuang.hmcl.Launcher)"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
    };
  };
}
