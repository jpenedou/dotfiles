Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)

require("zoxide"):setup({ update_db = true })
require("yaziline"):setup()
require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })
require("mime-ext"):setup({
	-- Expand the existing filename database (lowercase), for example:
	with_files = {
		makefile = "text/x-makefile",
		-- ...
	},

	-- Expand the existing extension database (lowercase), for example:
	with_exts = {
		mk = "text/x-makefile",
		heic = "image/heic",
		-- ...
	},

	-- If the mime-type is not in both filename and extension databases,
	-- then fallback to Yazi's preset `mime` plugin, which uses `file(1)`
	fallback_file1 = true,
})
require("starship"):setup()
