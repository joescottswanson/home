hyper = { "ctrl", "cmd", "alt" }
ctrl_cmd = { "ctrl", "cmd" }

hs.logger.defaultLogLevel="info"

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  hs.toggleConsole()
end)

hs.loadSpoon("SpoonInstall")

-- capture frame magic to make sure emacs doesn't steam my focus after launching a capture frame
hs.hotkey.bindSpec({hyper, "o"},
  function ()
    local focusedWindow = hs.window.focusedWindow()
    -- we may want to use orderedWindows if this drives me crazy - we could set it up to maintain window order in the screen by iterating over this and calling sendToBack on all of them so that it'll reorder them
    -- local orderedWindows = hs.window.orderedWindows()
    local o,s,t,r = hs.execute('/opt/homebrew/bin/emacsclient -ne "(make-capture-frame)"')
    if not s then
      print("Error when running org-capture: "..o.."\n")
    end
    local captureUIElement = hs.uielement.focusedElement()
    local watcher = captureUIElement:newWatcher(
      function ()
        focusedWindow:focus()
      end
    , focusedWindow)
    watcher:start({hs.uielement.watcher.elementDestroyed})
  end
)

spoon.SpoonInstall:andUse("MiroWindowsManager", {
    hotkeys = {
      up = { ctrl_cmd, "up" },
      down = { ctrl_cmd, "down" },
      right = { ctrl_cmd, "right" },
      left = { ctrl_cmd, "left" },
      fullscreen = { hyper, "up" },
      nextscreen = { hyper, "n" }
    }
})

hs.alert.show("Config loaded")