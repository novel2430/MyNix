{pkgs, opt-config, ...}:
{
  home.file.".config/rofi/config.rasi" = {
    text = ''
    * {
      background-color: #${opt-config.colors.dmenu-background};
      text-color: #${opt-config.colors.foreground};
      font: "Hack Nerd Font Regular 15";
      padding: 0px;
    }
    configuration {
      kb-element-next: "Tab,Control+j";
      kb-element-prev: "ISO_Left_Tab,Control+k";
      kb-remove-to-eol: "";
      kb-accept-entry: "Control+m,Return,KP_Enter";
    }
    window {
      background-color: #${opt-config.colors.dmenu-background};
      width: 25%;
      height: 40%;
      padding: 10px;
      border: 0;
    }
    mainbox {
      background-color: #${opt-config.colors.dmenu-background};
      children: [ inputbar, message, listview ];
      padding: 0px;
    }
    inputbar {
      text-color: #${opt-config.colors.foreground};
      background-color: #${opt-config.colors.dmenu-background};
      children: [ entry ];
      padding: 2px 5px;
      border: 2;
      border-color: #${opt-config.colors.foreground};
      border-radius: 12;
      margin: 0px 0px 10px 0px;
    }
    entry {
      placeholder: " Search";
      orientation: horizontal;
      background-color: #${opt-config.colors.dmenu-background};
      text-color: #${opt-config.colors.foreground};
      padding: 5px;
      blink: false;
    }
    listview {
      text-color: #${opt-config.colors.foreground};
      background-color: #${opt-config.colors.dmenu-background};
      padding: 0px;
      scrollbar: false;
      border: 0px;
    }
    element {
      children: [ element-text ];
      cursor: pointer;
      padding: 0px;
    }
    element-text selected {
      background-color: #${opt-config.colors.focus-background};
      padding: 10px;
    }
    element-text {
      text-color: #${opt-config.colors.foreground};
      background-color: #${opt-config.colors.dmenu-background};
      padding: 10px;
    }
    '';
  };
  home.packages = [
    pkgs.rofi-wayland
  ];
}
