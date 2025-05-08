local M = {}
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local config_var = require("config.var")
local modkey = config_var.modkey

-- Help Function
local client_in_tile = function(c)
  if c == nil or c.maximized or c.floating or c.fullscreen then
    return false
  end
  return true
end
local get_next_idx = function(t, i)
  return (i % #t) + 1
end
local get_prev_idx = function(t, i)
  return ((i - 2 + #t) % #t) + 1
end
local move_focus_to_client = function(prev, next)
  if prev.first_tag ~= next.first_tag then
    next.first_tag:view_only()
  end
  client.focus = next
end

M.globalkeys = gears.table.join(
-- TAG
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({ modkey, "Control" }, "Left", awful.tag.viewprev,
    { description = "view previous tag", group = "tag" }),
  awful.key({ modkey, "Control" }, "Right", awful.tag.viewnext,
    { description = "view next tag", group = "tag" }),
  awful.key({ modkey, }, "b", awful.tag.history.restore,
    { description = "go back", group = "tag" }),
  -- Client
  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.spawn(config_var.cmd.terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, }, "d", function() awful.spawn(config_var.cmd.d_launcher) end,
    { description = "open a Rofi (drun)", group = "launcher" }),
  awful.key({ modkey, }, "r", function() awful.spawn(config_var.cmd.r_launcher) end,
    { description = "open a Rofi (run)", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "f", function() awful.spawn(config_var.cmd.web_browser) end,
    { description = "open Web Browser", group = "launcher" }),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn(config_var.cmd.volume_up) end,
    { description = "Audio Volume up", group = "launcher" }),
  awful.key({}, "XF86AudioLowerVolume", function() awful.spawn(config_var.cmd.volume_down) end,
    { description = "Audio Volume down", group = "launcher" }),
  awful.key({}, "XF86AudioMute", function() awful.spawn(config_var.cmd.volume_mute) end,
    { description = "Audio Volume mute toggle", group = "launcher" }),
  awful.key({}, "Print", function() awful.spawn(config_var.cmd.screenshot) end,
    { description = "Screenshot", group = "launcher" }),
  awful.key({ modkey }, "Print", function() awful.spawn(config_var.cmd.screenshot_select) end,
    { description = "Screenshot with Select", group = "launcher" }),
  awful.key({}, "XF86MonBrightnessUp", function() awful.spawn(config_var.cmd.brightness_up) end,
    { description = "Brightness Up", group = "launcher" }),
  awful.key({}, "XF86MonBrightnessDown", function() awful.spawn(config_var.cmd.brightness_down) end,
    { description = "Brightness Down", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "l", function() awful.spawn(config_var.cmd.lock_screen) end,
    { description = "Lock Screen", group = "launcher" }),
  awful.key({ modkey }, "c", function() awful.spawn(config_var.cmd.greenclip_rofi) end,
    { description = "Show Clipboard", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "p", function() awful.spawn(config_var.cmd.power_menu) end,
    { description = "Power Menu", group = "launcher" }),

  awful.key({ modkey, "Shift" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "e", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" })
)

M.last_swap = nil
M.last_layout_max = {}
M.last_layout_float = {}
M.last_layout_tile = {}

M.clientkeys = gears.table.join(
  awful.key({ modkey, }, "Tab",
    function()
      local all_clients = client.get()
      local focus_client_idx = gears.table.hasitem(all_clients, client.focus)
      if focus_client_idx == nil then
        return
      end
      move_focus_to_client(client.focus, all_clients[get_next_idx(all_clients, focus_client_idx)])
    end,
    { description = "cycle to next client in global", group = "client" }),
  awful.key({ modkey, }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ modkey, }, "space", awful.client.floating.toggle,
    { description = "toggle client floating", group = "client" }),
  awful.key({ modkey, "Shift" }, "Return", function(c)
      -- Is Clinet tile
      if not client_in_tile(c) then
        return
      end
      -- Is M.last_swap valid
      if M.last_swap ~= nil and M.last_swap.valid == false then
        M.last_swap = nil
      end
      if M.last_swap ~= nil and not client_in_tile(M.last_swap) then
        M.last_swap = nil
      end
      -- Build Target
      local target = nil
      -- Is Current Master Floating
      if not client_in_tile(awful.client.getmaster()) then
        return
      end
      -- Is Client Master
      if c == awful.client.getmaster() and M.last_swap ~= nil and M.last_swap ~= c then
        target = M.last_swap
        M.last_swap = c -- master
      elseif c == awful.client.getmaster() then
        for cc in awful.client.iterate(client_in_tile) do
          if c ~= cc then
            target = cc
            break
          end
        end
        M.last_swap = c -- master
      else
        target = awful.client.getmaster()
        M.last_swap = target
      end
      -- Do Swap
      if target ~= nil then
        c:swap(target)
        client.focus = awful.client.getmaster()
      end
    end,
    { description = "toggle master (tile mode)", group = "client" }),
  awful.key({ modkey, }, "m",
    function()
      local current_tag = awful.screen.focused().selected_tag
      if not current_tag then return end
      local current_tag_layout = current_tag.layout
      if not current_tag_layout then return end

      if current_tag_layout == awful.layout.suit.max then
        if M.last_layout_max[current_tag] then
          -- Max -> Last Layout
          awful.layout.set(M.last_layout_max[current_tag], current_tag)
        else
          -- Max -> Tile
          awful.layout.set(awful.layout.suit.tile, current_tag)
        end
      else
        -- Any -> Max
        M.last_layout_max[current_tag] = current_tag_layout
        awful.layout.set(awful.layout.suit.max, current_tag)
      end
    end,
    { description = "maximize layout toggle", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space",
    function()
      local current_tag = awful.screen.focused().selected_tag
      if not current_tag then return end
      local current_tag_layout = current_tag.layout
      if not current_tag_layout then return end

      if current_tag_layout == awful.layout.suit.floating then
        if M.last_layout_float[current_tag] then
          -- Float -> Last Layout
          awful.layout.set(M.last_layout_float[current_tag], current_tag)
        else
          -- Float -> Tile
          awful.layout.set(awful.layout.suit.tile, current_tag)
        end
      else
        -- Any -> Float
        M.last_layout_float[current_tag] = current_tag_layout
        awful.layout.set(awful.layout.suit.floating, current_tag)
      end
    end,
    { description = "floating layout toggle", group = "layout" }),
  awful.key({ modkey, }, "e",
    function()
      local current_tag = awful.screen.focused().selected_tag
      if not current_tag then return end
      local current_tag_layout = current_tag.layout
      if not current_tag_layout then return end

      if current_tag_layout == awful.layout.suit.tile then
        if M.last_layout_tile[current_tag] then
          -- tile -> Last Layout
          awful.layout.set(M.last_layout_tile[current_tag], current_tag)
        end
      else
        -- Any -> tile
        M.last_layout_tile[current_tag] = current_tag_layout
        awful.layout.set(awful.layout.suit.tile, current_tag)
      end
    end,
    { description = "tile layout toggle", group = "layout" }),
  awful.key({ modkey, "Shift" }, "m",
    function(c)
      c.maximized = not c.maximized
      c:raise()
    end,
    { description = "(un)maximize client toggle", group = "client" })
)

M.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ config_var.modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ config_var.modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

M.run = function()
  for i = 1, 9 do
    M.globalkeys = gears.table.join(M.globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            tag:view_only()
          end
        end,
        { description = "view tag #" .. i, group = "tag" }),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
        function()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        { description = "move focused client to tag #" .. i, group = "tag" }),
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", }, "#" .. i + 9,
        function()
          local screen = awful.screen.focused()
          local current_tag = screen.selected_tag
          local source_tag = screen.tags[i]
          if current_tag and source_tag and source_tag ~= current_tag then
            for _, c in ipairs(source_tag:clients()) do
              c:toggle_tag(current_tag)
            end
          end
          if current_tag then
            awful.layout.arrange(screen)
          end
        end,
        { description = "toggle clients from tag " .. i .. " into current tag", group = "tag" })
    )
  end
  root.keys(M.globalkeys)
end

return M
