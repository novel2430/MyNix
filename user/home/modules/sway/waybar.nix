{opt-config, ...}:
{
  home.file.".config/sway/waybar.css" = {
    text = ''
    * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: Hack Nerd Font, HackGen35 Console NF, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        font-size: 16px;
        min-height: 25px;
        padding: 0;
        margin: 0;
    }

    window#waybar {
        background-color: #${opt-config.colors.bar-background};
        color: #${opt-config.colors.foreground};
        transition-property: background-color;
        transition-duration: .5s;
    }

    button {
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each button name */
        border: none;
        border-radius: 0px;
    }

    button:hover {
        background: inherit;
        box-shadow: inset 0 -3px #${opt-config.colors.foreground};
        border-radius: 0px;
    }

    #workspaces button { /* be show in occupied */
      font-weight: bold;
      padding: 0px 6px;
      color: #${opt-config.colors.gray};
      border-radius: 0px;
      background-color: transparent;
    }

    #workspaces button.focused {
      color: #${opt-config.colors.foreground};
      background-color: #${opt-config.colors.focus-background};
      border-radius: 0px;
    }

    #workspaces button.urgent {
      color: #${opt-config.colors.foreground};
      background-color: #${opt-config.colors.red};
      border-radius: 0px;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #wireplumber,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #scratchpad,
    #power-profiles-daemon,
    #mpd {
        padding-right: 5px;
        padding-left: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        background-color: transparent;
        color: #${opt-config.colors.foreground};
        margin: 0;
    }

    #battery {
        background-color: transparent;
        color: #${opt-config.colors.foreground};
    }

    #battery.charging, #battery.plugged {
        color: #${opt-config.colors.green};
        background-color: transparent;
    }

    #custom-temperature {
        padding-right: 5px;
        padding-left: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        background-color: transparent;
        color: #${opt-config.colors.foreground};
        margin: 0;
    }

    #custom-weather {
        padding-right: 5px;
        padding-left: 5px;
        padding-top: 0px;
        padding-bottom: 0px;
        background-color: transparent;
        color: #${opt-config.colors.foreground};
        margin: 0;
    }

    #tray {
        background-color: #${opt-config.colors.focus-background};
        color: #${opt-config.colors.foreground};
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
    }
    '';
  };
}
