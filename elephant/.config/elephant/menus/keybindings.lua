Name = "keybindings"
NamePretty = "Key Bindings"
--Icon = "icon-name"
FixedOrder = true
local separator = " + "

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
                local tmp = table.concat(modmask) .. key
                table.insert(entries, { Text = tmp, Subtext = description})
                modmask = {}
                key = ""
                description = ""
            end
        end

    end

--    for line in handle:lines() do
--        table.insert(entries, {Text = line, Actions = {}})
--    end

    handle:close()
    return entries
end

--function MyAction()
--    RunInTerminal("my-command")
--end
