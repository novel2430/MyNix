{opt-config, ...}:
{
  home.file.".config/openbox/config.ini" = {
    text = ''
    [colors]
    background = #${opt-config.colors.bar-background}
    background-alt = #${opt-config.colors.focus-background}
    foreground = #${opt-config.colors.foreground}
    gray-foreground = #${opt-config.colors.gray}
    primary = #${opt-config.colors.focus-background}
    alert = #${opt-config.colors.red}

    [bar/example]
    width = 100%
    height = 18pt
    radius = 0

    ; dpi = 96

    background = ''${colors.background}
    foreground = ''${colors.foreground}

    line-size = 2pt

    border-size = 0pt
    border-color = #00000000

    padding-left = 0
    padding-right = 0

    module-margin = 0


    font-0 = Hack Nerd Font;2
    font-1 = Hack Nerd Font:weight=bold;2
    font-2 = WenQuanYi Zen Hei Mono;2

    fixed-center = true

    modules-left = xworkspaces
    modules-center = date 
    modules-right = custom-bat custom-temp memory cpu systray

    cursor-click = pointer
    cursor-scroll = ns-resize

    enable-ipc = true

    ; wm-restack = generic
    ; wm-restack = bspwm
    ; wm-restack = i3

    ; override-redirect = true

    [module/systray]
    type = internal/tray
    format-margin = 5pt
    tray-spacing = 5pt

    [module/xwindow]
    type = internal/xwindow
    label = %title:0:60:...%
    label-padding-left = 0

    [module/memory]
    type = internal/memory
    interval = 2
    label-foreground = ''${colors.foreground}
    label =  %percentage_used:%%
    label-padding-right = 1

    [module/cpu]
    type = internal/cpu
    interval = 2
    label-foreground = ''${colors.foreground}
    label =  %percentage:%%
    label-padding-right = 1

    [module/date]
    type = internal/date
    interval = 1
    date =  %Y-%m-%d %H:%M
    date-alt =  %H:%M
    label = %date%
    label-foreground = ''${colors.foreground}
    label-padding = 1

    [module/xworkspaces]
    type = internal/xworkspaces
    ; Only show workspaces defined on the same output as the bar
    ;
    ; Useful if you want to show monitor specific workspaces
    ; on different bars
    ;
    ; Default: false
    pin-workspaces = false 
    ; Groups workspaces by monitor. If set to false, workspaces are not grouped and
    ; appear in the order provided by the WM
    ; If set to false, cannot be used together with label-monitor
    ; New in version 3.7.0
    ; Default: true
    group-by-monitor = true 
    ; Create click handler used to focus desktop
    ; Default: true
    enable-click = true
    ; Create scroll handlers used to cycle desktops
    ; Default: true
    enable-scroll = false
    ; Reverse the scroll direction
    ; Default: false
    ; New in version 3.6.0
    reverse-scroll = true
    ; active = Used for the currently selected workspaces
    label-active = %name%
    label-active-background = ''${colors.background-alt}
    label-active-padding = 1
    label-active-font = 2
    ; occupied = Used for workspaces at least one window
    label-occupied = %name%
    label-occupied-background = ''${colors.background}
    label-occupied-padding = ''${self.label-active-padding}
    label-occupied-font = 2
    ; urgent = Used for workspaces containing a window that is demanding attention
    label-urgent = %name%
    label-urgent-background = ''${colors.alert}
    label-urgent-padding = ''${self.label-active-padding}
    ; empty = Used for workspaces without windows
    label-empty = %name%
    label-empty-background = ''${colors.background}
    label-empty-foreground = ''${colors.gray-foreground}
    label-empty-padding = ''${self.label-active-padding}

    [module/custom-temp]
    type = custom/script
    exec = python "$HOME/.config/openbox/temp.py"
    interval = 5
    label = %output%
    label-padding-right = 1

    [module/custom-bat]
    type = custom/script
    exec = python "$HOME/.config/openbox/bat.py"
    interval = 5
    label = %output%
    label-padding-right = 1

    [settings]
    screenchange-reload = true
    pseudo-transparency = true

    ; vim:ft=dosini
    '';
  };
}
