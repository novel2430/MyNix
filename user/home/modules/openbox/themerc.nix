{opt-config, ...}:
{
  home.file.".themes/mytheme/openbox-3/themerc" = {
    text = ''
    border.width: 2
    window.client.padding.width: 0
    window.client.padding.height: 0
    window.button.height: 20
    window.handle.width: 0

    # Active Window
    window.active.border.color: #${opt-config.colors.focus-background}
    window.active.title.bg: Flat Solid
    window.active.title.bg.color: #${opt-config.colors.focus-background}
    window.active.label.bg: Flat Solid 
    window.active.label.bg.color: #${opt-config.colors.focus-background}
    window.active.label.text.color: #${opt-config.colors.foreground}
    window.active.shadow.size: 0

    # Inactive Window
    window.inactive.border.color: #${opt-config.colors.unfocus-border}
    window.inactive.title.bg: Flat Solid
    window.inactive.title.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.label.bg: Flat Solid 
    window.inactive.label.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.label.text.color: #${opt-config.colors.foreground}
    window.inactive.shadow.size: 0

    # OSD
    osd.border.width: 0
    osd.bg: Flat Solid
    osd.bg.color: #${opt-config.colors.dmenu-background}
    osd.active.label.bg: Flat Solid
    osd.active.label.bg.color: #${opt-config.colors.focus-background}
    osd.hilight.bg: Flat Solid 
    osd.hilight.bg.color: #${opt-config.colors.focus-background}
    osd.inactive.label.bg: Flat Solid
    osd.inactive.label.bg.color: #${opt-config.colors.dmenu-background}
    osd.unhilight.bg: Flat Solid 
    osd.unhilight.bg.color: #${opt-config.colors.dmenu-background}
    osd.label.text.color: #${opt-config.colors.foreground}
    osd.inlabel.text.color: #${opt-config.colors.foreground}

    # Menu settings
    menu.border.color: #${opt-config.colors.foreground}
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
    window.active.button.unpressed.bg: Flat Solid 
    window.active.button.unpressed.bg.color: #${opt-config.colors.focus-background}
    window.active.button.unpressed.image.color: #${opt-config.colors.foreground}
    window.active.button.pressed.bg: Flat Solid 
    window.active.button.pressed.bg.color: #${opt-config.colors.focus-background}
    window.active.button.pressed.image.color: #${opt-config.colors.foreground}
    window.active.button.hover.bg: Flat Solid 
    window.active.button.hover.bg.color: #${opt-config.colors.focus-background}
    window.active.button.hover.image.color: #${opt-config.colors.foreground}
    window.active.button.toggled.unpressed.bg: Flat Solid 
    window.active.button.toggled.unpressed.bg.color: #${opt-config.colors.focus-background}
    window.active.button.toggled.unpressed.image.color: #${opt-config.colors.foreground}
    window.active.button.toggled.pressed.bg: Flat Solid 
    window.active.button.toggled.pressed.bg.color: #${opt-config.colors.focus-background}
    window.active.button.toggled.pressed.image.color: #${opt-config.colors.foreground}
    window.active.button.toggled.hover.bg: Flat Solid 
    window.active.button.toggled.hover.bg.color: #${opt-config.colors.focus-background}
    window.active.button.toggled.hover.image.color: #${opt-config.colors.foreground}
    window.inactive.button.unpressed.bg: Flat Solid 
    window.inactive.button.unpressed.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.unpressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.pressed.bg: Flat Solid 
    window.inactive.button.pressed.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.pressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.hover.bg: Flat Solid 
    window.inactive.button.hover.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.hover.image.color: #${opt-config.colors.foreground}
    window.inactive.button.toggled.unpressed.bg: Flat Solid 
    window.inactive.button.toggled.unpressed.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.toggled.unpressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.toggled.pressed.bg: Flat Solid 
    window.inactive.button.toggled.pressed.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.toggled.pressed.image.color: #${opt-config.colors.foreground}
    window.inactive.button.toggled.hover.bg: Flat Solid 
    window.inactive.button.toggled.hover.bg.color: #${opt-config.colors.unfocus-border}
    window.inactive.button.toggled.hover.image.color: #${opt-config.colors.foreground}
    '';
  };
}
