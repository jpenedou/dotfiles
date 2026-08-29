--- @sync entry
local function entry()
  local h = cx.active.current.hovered
  if not h then return end
  if h.cha.is_dir then return end
  ya.emit("shell", { block = true, run = string.format("nvim %q", tostring(h.url)) })
end
return { entry = entry }
