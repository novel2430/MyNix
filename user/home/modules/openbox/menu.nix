{ pkgs, opt-config, custom-pkgs, ... }:
let
  terminal = "${pkgs.wezterm}/bin/wezterm";
  browser = "${pkgs.nur.repos.novel2430.zen-browser-bin}/bin/zen-browser";
  file = "${pkgs.nemo}/bin/nemo";
  spotify = "${pkgs.spotify}/bin/spotify";
  wechat = "${pkgs.nur.repos.novel2430.wechat-universal-bwrap}/bin/wechat-universal-bwrap";
  pwvucontrol = "${pkgs.pwvucontrol}/bin/pwvucontrol";
  networkmanager = "${pkgs.networkmanager}/bin";
  flatpak = "${pkgs.flatpak}/bin/flatpak";
  #gedit = "${custom-pkgs.gedit}/bin/gedit";
  obs = "${pkgs.obs-studio}/bin/obs";
  dingtalk = "dingtalk";
  brave = "${pkgs.brave}/bin/brave";
  fcitx5-configtool = "${pkgs.fcitx5}/bin/fcitx5-configtool";
  motrix = "${pkgs.motrix}/bin/motrix";
  yazi = "${pkgs.yazi}/bin/yazi";
in
{
  home.file.".config/openbox/menu.xml" = {
    executable = false;
    text = ''
    <?xml version="1.0" encoding="utf-8"?>
    <openbox_menu xmlns="https://openbox.org/" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://openbox.org/">
      <menu id="root-menu" label="Menu">
        <menu
          id="often-menu"
          label="Often"
        >
          <item label="Terminal">
            <action name="Execute">
              <execute>${terminal}</execute>
            </action>
          </item>
          <item label="Web Browser">
            <action name="Execute">
              <execute>${browser}</execute>
            </action>
          </item>
          <item label="File">
            <action name="Execute">
              <execute>${file}</execute>
            </action>
          </item>
          <item label="Spotify">
            <action name="Execute">
              <execute>${spotify}</execute>
            </action>
          </item>
          <item label="Wechat">
            <action name="Execute">
              <execute>${wechat}</execute>
            </action>
          </item>
          <item label="Gedit">
            <action name="Execute">
              <execute>gedit</execute>
            </action>
          </item>
        </menu>
        <menu
          id="screenshot-menu"
          label="Screenshot"
        >
          <item label="Full Screenshot">
            <action name="Execute">
              <execute>maim-screenshot full</execute>
            </action>
          </item>
          <item label="Select Screenshot">
            <action name="Execute">
              <execute>maim-screenshot select</execute>
            </action>
          </item>
          <item label="Full then Edit Screenshot">
            <action name="Execute">
              <execute>maim-screenshot full-edit</execute>
            </action>
          </item>
          <item label="Selct then Edit Screenshot">
            <action name="Execute">
              <execute>maim-screenshot select-edit</execute>
            </action>
          </item>
        </menu>
        <menu
          id="tools-menu"
          label="Tools"
        >
          <item label="Pipewire Volume Control">
            <action name="Execute">
              <execute>${pwvucontrol}</execute>
            </action>
          </item>
          <item label="Network Editer">
            <action name="Execute">
              <execute>${terminal} -e ${networkmanager}/nmtui</execute>
            </action>
          </item>
          <item label="Fcitx5 Configure">
            <action name="Execute">
              <execute>${fcitx5-configtool}</execute>
            </action>
          </item>
        </menu>
        <menu
          id="games-menu"
          label="Games"
        >
          <item label="Lutris">
            <action name="Execute">
              <execute>lutris</execute>
            </action>
          </item>
          <item label="Steam">
            <action name="Execute">
              <execute>steam</execute>
            </action>
          </item>
          <item label="HMCL">
            <action name="Execute">
              <execute>hmcl</execute>
            </action>
          </item>
          <item label="PPSSPP">
            <action name="Execute">
              <execute>${flatpak} run org.ppsspp.PPSSPP</execute>
            </action>
          </item>
          <item label="Ryujinx">
            <action name="Execute">
              <execute>ryujinx</execute>
            </action>
          </item>
          <item label="Openttd">
            <action name="Execute">
              <execute>openttd</execute>
            </action>
          </item>
        </menu>
        <menu
          id="media-menu"
          label="Media"
        >
          <item label="VLC">
            <action name="Execute">
              <execute>vlc</execute>
            </action>
          </item>
          <item label="Spotify">
            <action name="Execute">
              <execute>${spotify}</execute>
            </action>
          </item>
        </menu>
        <menu
          id="other-menu"
          label="Others"
        >
          <item label="OBS Studio">
            <action name="Execute">
              <execute>${obs}</execute>
            </action>
          </item>
          <item label="Shotcut">
            <action name="Execute">
              <execute>shotcut</execute>
            </action>
          </item>
          <item label="Motrix">
            <action name="Execute">
              <execute>${motrix}</execute>
            </action>
          </item>
          <item label="Yazi">
            <action name="Execute">
              <execute>${terminal} -e ${yazi}</execute>
            </action>
          </item>
          <item label="Dingtalk">
            <action name="Execute">
              <execute>${dingtalk}</execute>
            </action>
          </item>
          <item label="Baidu Netdisk">
            <action name="Execute">
              <execute>baidunetdisk</execute>
            </action>
          </item>
          <item label="Brave Browser">
            <action name="Execute">
              <execute>${brave}</execute>
            </action>
          </item>
        </menu>
        <menu
          id="power-menu"
          label="Power"
        >
          <item label="Lock">
            <action name="Execute">
              <execute>x-lock</execute>
            </action>
          </item>
          <item label="Reboot">
            <action name="Execute">
              <execute>${pkgs.systemd}/bin/reboot</execute>
            </action>
          </item>
          <item label="Back to TTY">
            <action name="Exit">
              <prompt>no</prompt>
            </action>
          </item>
          <item label="Log out">
            <action name="Execute">
              <execute>${pkgs.systemd}/bin/loginctl terminate-user ${opt-config.username}</execute>
            </action>
          </item>
          <item label="Shutdown Now">
            <action name="Execute">
              <execute>${pkgs.systemd}/bin/poweroff</execute>
            </action>
          </item>
        </menu>
        <item label="Reconfigure">
          <action name="Reconfigure"/>
        </item>
      </menu>
    </openbox_menu>
    '';
  };

}
