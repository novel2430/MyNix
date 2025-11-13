{opt-config, ...}:
{
  home.file.".themes/mytheme/labwc/themerc" = {
    text = ''
    border.width: 2
    window.button.width: 36
    osd.bg.color: #${opt-config.colors.dmenu-background}
    window.titlebar.padding.height: 2
    window.button.height: 20

    # Active Window
    window.active.border.color: #${opt-config.colors.focus-background}
    window.active.title.bg.color: #${opt-config.colors.focus-background}
    window.active.label.text.color: #${opt-config.colors.foreground}
    window.active.shadow.size: 0

    # Inactive Window
    window.inactive.border.color: #${opt-config.colors.unfocus-border}
    window.inactive.title.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.label.text.color: #${opt-config.colors.foreground}
    window.inactive.shadow.size: 0

    # Window Switcher
    osd.window-switcher.width: 25%
    osd.window-switcher.preview.border.width: 2
    osd.window-switcher.preview.border.color: #${opt-config.colors.foreground}

    # Workspace Switcher
    osd.workspace-switcher.boxes.width: 0
    osd.workspace-switcher.boxes.height: 0
    osd.workspace-switcher.boxes.border.width: 0

    # Snapping
    snapping.overlay.region.bg.enabled: yes
    snapping.overlay.edge.bg.enabled: yes
    snapping.overlay.region.bg.color: #${opt-config.colors.bar-background}af
    snapping.overlay.edge.bg.color: #${opt-config.colors.bar-background}af
    snapping.overlay.region.border.enabled: yes
    snapping.overlay.edge.border.enabled: yes
    snapping.overlay.region.border.width: 2
    snapping.overlay.edge.border.width: 2
    snapping.overlay.region.border.color: #${opt-config.colors.focus-background}
    snapping.overlay.edge.border.color: #${opt-config.colors.focus-background}

    # Menu settings
    menu.border.color: #${opt-config.colors.foreground}
    menu.border.width: 0
    menu.title.bg: Flat Solid
    menu.title.bg.color: #${opt-config.colors.dmenu-background}
    menu.title.text.color: #${opt-config.colors.foreground}
    menu.items.bg: Flat Solid
    menu.items.bg.color: #${opt-config.colors.dmenu-background}
    menu.items.text.color: #${opt-config.colors.foreground}
    menu.items.active.bg: Flat Solid 
    menu.items.active.bg.color: #${opt-config.colors.focus-background}
    menu.items.active.bg.border.color: #${opt-config.colors.foreground}
    menu.items.active.text.color: #${opt-config.colors.foreground}
    menu.separator.width: 1
    menu.separator.padding.width: 0
    menu.separator.padding.height: 3
    menu.separator.color: #${opt-config.colors.foreground}

    # Title Bar Btn (xbm)
    ## Close
    window.active.button.close.unpressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.close.unpressed.image.color: #${opt-config.colors.foreground}
    ## Max
    window.active.button.max.unpressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.max.unpressed.image.color: #${opt-config.colors.foreground}
    ## Iconify
    window.active.button.iconify.unpressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.iconify.unpressed.image.color: #${opt-config.colors.foreground}
    '';
  };
}
