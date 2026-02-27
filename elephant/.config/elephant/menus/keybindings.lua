Name = "keybindings"
NamePretty = "Key Bindings"
--Icon = "icon-name"
FixedOrder = true
local separator = " + "
--local grp_prefix = "                "

local groups = {
    {
        name = "Hyprland",
        regex = {"Launch", "Close window", "Toggle window", "Pseudo window", "key bindings"},
        entries = {}
    },
    {
        name = "Group Control",
        regex = {"group"},
        entries = {}
    },
    {
        name = "Notifications",
        regex = {"notification"},
        entries = {}
    },
    {
        name = "Wondow / Workspace actions",
        regex = {"workspace"},
        entries = {}
    },
    {
        name = "Audio",
        regex = {"Volume", "Track", "audio"},
        entries = {}
    },
    {
        name = "Miscellaneous",
        regex = {},
        entries = {}
    }
}

local function format_entry(modmask, key, description)
    return { Text = description, Subtext = table.concat(modmask) .. key }
end

local function insert_into_group(modmask, key, description)
    local sub = description:lower()
    for _, group in ipairs(groups) do
        for _, pattern in ipairs(group.regex) do
            if sub:match(pattern:lower()) then
                table.insert(group.entries, format_entry(modmask, key, description))
                return
            end
        end
    end
    table.insert(groups[#groups].entries, format_entry(modmask, key, description))
end

local function hasbit(x, b)
    return math.floor(x / b) % 2 == 1
end

function GetEntries()
    local entries = {}
    local handle = io.popen("hyprctl binds")

    if not handle then
        return {
            { Text = "Failed to run hyprctl binds" }
        }
    end
    
    local modmask = {}
    local key = ""
    local description = ""
--    local dispatcher = ""
--    local args = ""
    while true do
        local line = handle:read()
        if line == nil then break end
        if line:match("^%s+modmask: ") then
            local num = string.gsub(line, "^%s+modmask:%s", "") + 0

            if hasbit(num, 64) then table.insert(modmask, "Super" .. separator) end
            if hasbit(num, 4) then table.insert(modmask, "Ctrl" .. separator) end
            if hasbit(num, 8) then table.insert(modmask, "Alt" .. separator) end
            if hasbit(num, 1)  then table.insert(modmask, "Shift" .. separator) end
        end

        if line:match("^%s+key: ") then
            key = string.sub(line, 7)
        end

        if line:match("^%s+description: ") then
            description = string.sub(line, 15)
        end
       
        if line == "" then
            if key ~= "" then
                insert_into_group(modmask, key, description)
                modmask = {}
                key = ""
                description = ""
--                dispatcher = ""
--                args = ""
            end
        end

    end

    handle:close()
    
    local final = {}

    for _, group in ipairs(groups) do
        if #group.entries > 0 then
           --table.insert(final, { Text = grp_prefix .. group.name,})

            for _, entry in ipairs(group.entries) do
                table.insert(final, entry)
            end
        end
    end

--    for line in handle:lines() do
--        table.insert(entries, {Text = line, Actions = {}})
--    end

    return final
end

--function MyAction()
--    RunInTerminal("my-command")
--end
