{ pkgs, opt-config, ... }:

{
  home.file.".config/foot/foot.ini" = {
    text = ''
      # -*- conf -*-

      # shell=$SHELL (if set, otherwise user's default shell from /etc/passwd)
      # term=foot
      term=xterm-256color
      # login-shell=no

      # app-id=foot
      # title=foot
      # locked-title=no

      font=Hack Nerd Font:weight=regular:size=${opt-config.alacritty-font-size}
      # font-bold=<bold variant of regular font>
      # font-italic=<italic variant of regular font>
      # font-bold-italic=<bold+italic variant of regular font>
      # font-size-adjustment=0.5
      # line-height=<font metrics>
      # letter-spacing=0
      # horizontal-letter-offset=0
      # vertical-letter-offset=0
      # underline-offset=<font metrics>
      # underline-thickness=<font underline thickness>
      # box-drawings-uses-font-glyphs=no
      # dpi-aware=auto

      # initial-window-size-pixels=700x500  # Or,
      # initial-window-size-chars=<COLSxROWS>
      initial-window-mode=maximized
      # pad=0x0                             # optionally append 'center'
      # resize-delay-ms=100

      # notify=notify-send -a ''${app-id} -i ''${app-id} ''${title} ''${body}

      # bold-text-in-bright=no
      # word-delimiters=,│`|:"'()[]{}<>
      # selection-target=primary
      # workers=<number of logical CPUs>
      # utempter=/usr/lib/utempter/utempter

      [environment]
      # name=value

      [bell]
      # urgent=no
      # notify=no
      # command=
      # command-focused=no

      [scrollback]
      lines=10000
      # multiplier=3.0
      # indicator-position=relative
      # indicator-format=""

      [url]
      # launch=xdg-open ''${url}
      # label-letters=sadfjklewcmpgh
      # osc8-underline=url-mode
      # protocols=http, https, ftp, ftps, file, gemini, gopher
      # uri-characters=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]

      [cursor]
      # style=block
      # color=<inverse foreground/background>
      # blink=no
      # beam-thickness=1.5
      # underline-thickness=<font underline thickness>

      [mouse]
      # hide-when-typing=no
      # alternate-scroll-mode=yes

      [colors]
      alpha=0.9
      # Defualt
      #background=1C2E36
      #foreground=E0DEDA
      # Nord Nightfox Theme
      background=2e3440
      foreground=cdcecf
      regular0=3b4252
      regular1=bf616a
      regular2=a3be8c
      regular3=ebcb8b
      regular4=81a1c1
      regular5=b48ead
      regular6=88c0d0
      regular7=e5e9f0
      bright0=465780
      bright1=d06f79
      bright2=b1d196
      bright3=f0d399
      bright4=8cafd2
      bright5=c895bf
      bright6=93ccdc
      bright7=e7ecf4
      # Adwaita Dark Theme
      #background=1d1d1d
      #foreground=deddda
      #regular0=1d1d1d
      #regular1=ed333b
      #regular2=57e389
      #regular3=ff7800
      #regular4=62a0ea
      #regular5=9141ac
      #regular6=5bc8af
      #regular7=deddda
      #bright0=9a9996
      #bright1=f66151
      #bright2=8ff0a4
      #bright3=ffa348
      #bright4=99c1f1
      #bright5=dc8add
      #bright6=93ddc2
      #bright7=f6f5f4

      ## Bright colors (color palette 8-15)

      ## dimmed colors (see foot.ini(5) man page)
      # dim0=<not set>
      # ...
      # dim7=<not-set>

      ## The remaining 256-color palette
      # 16 = <256-color palette #16>
      # ...
      # 255 = <256-color palette #255>

      ## Misc colors
      # selection-foreground=<inverse foreground/background>
      # selection-background=<inverse foreground/background>
      # jump-labels=<regular0> <regular3>          # black-on-yellow
      # scrollback-indicator=<regular0> <bright4>  # black-on-bright-blue
      # search-box-no-match=<regular0> <regular1>  # black-on-red
      # search-box-match=<regular0> <regular3>     # black-on-yellow
      # urls=<regular3>

      [csd]
      # preferred=server
      # size=26
      # font=<primary font>
      # color=<foreground color>
      # hide-when-typing=no
      # border-width=0
      # border-color=<csd.color>
      # button-width=26
      # button-color=<background color>
      # button-minimize-color=<regular4>
      # button-maximize-color=<regular2>
      # button-close-color=<regular1>

      [key-bindings]
      scrollback-up-page=Control+Shift+Page_Up
      # scrollback-up-half-page=none
      scrollback-up-line=Control+Shift+k
      scrollback-down-page=Control+Shift+Page_Down
      # scrollback-down-half-page=none
      scrollback-down-line=Control+Shift+j
      clipboard-copy=Control+Shift+c XF86Copy
      clipboard-paste=Control+Shift+v XF86Paste
      # primary-paste=Shift+Insert
      # search-start=Control+Shift+f
      font-increase=Control+plus Control+equal Control+KP_Add
      font-decrease=Control+minus Control+KP_Subtract
      # font-reset=Control+0 Control+KP_0
      # spawn-terminal=Control+Shift+n
      # minimize=none
      # maximize=none
      # fullscreen=none
      # pipe-visible=[sh -c "xurls | fuzzel | xargs -r firefox"] none
      # pipe-scrollback=[sh -c "xurls | fuzzel | xargs -r firefox"] none
      # pipe-selected=[xargs -r firefox] none
      # show-urls-launch=Control+Shift+u
      # show-urls-copy=none
      # show-urls-persistent=none
      # prompt-prev=Control+Shift+z
      # prompt-next=Control+Shift+x
      # unicode-input=none
      # noop=none

      [search-bindings]
      # cancel=Escape
      # commit=Return
      # find-prev=Control+n
      # find-next=Control+p
      # cursor-left=Left Control+b
      # cursor-left-word=Control+Left Mod1+b
      # cursor-right=Right Control+f
      # cursor-right-word=Control+Right Mod1+f
      # cursor-home=Home Control+a
      # cursor-end=End Control+e
      # delete-prev=BackSpace
      # delete-prev-word=Mod1+BackSpace Control+BackSpace
      # delete-next=Delete
      # delete-next-word=Mod1+d Control+Delete
      # extend-to-word-boundary=Control+w
      # extend-to-next-whitespace=Control+Shift+w
      # clipboard-paste=Control+v Control+Shift+v Control+y XF86Paste
      # primary-paste=Shift+Insert
      # unicode-input=none

      [url-bindings]
      # cancel=Control+g Control+c Control+d Escape
      # toggle-url-visible=t

      [text-bindings]
      # \x03=Mod4+c  # Map Super+c -> Ctrl+c

      [mouse-bindings]
      # selection-override-modifiers=Shift
      # primary-paste=BTN_MIDDLE
      # select-begin=BTN_LEFT
      # select-begin-block=Control+BTN_LEFT
      # select-extend=BTN_RIGHT
      # select-extend-character-wise=Control+BTN_RIGHT
      # select-word=BTN_LEFT-2
      # select-word-whitespace=Control+BTN_LEFT-2
      # select-row=BTN_LEFT-3

      # vim: ft=dosini
    '';
  };
  home.packages = [
    pkgs.foot
  ];
}
