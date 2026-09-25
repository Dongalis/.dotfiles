-- App-specific tweaks.
local paths = require("default.hypr.paths")
local require_all = require("default.hypr.require_all")

require_all.files(os.getenv("HOME") .. "/.config/hypr/apps", "hypr.apps")

