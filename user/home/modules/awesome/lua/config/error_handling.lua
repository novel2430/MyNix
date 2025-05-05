local M = {}
local awful = require("awful")
M.run = function()
  if awesome.startup_errors then
    awful.spawn("dunstify 'Awesome Startup Error' '" .. tostring(awesome.startup_errors) .. "'")
  end

  -- Handle runtime errors after startup
  do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true
      awful.spawn("dunstify 'Awesome Error' '" .. tostring(err) .. "'")
      in_error = false
    end)
  end
end
return M
