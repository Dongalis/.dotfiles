Name = "keybindings"
NamePretty = "Key Bindings"
--Icon = "icon-name"
FixedOrder = true

function GetEntries()
    local entries = {}
    local handle = io.popen("hyprctl binds")

    if not handle then
        return {
            { Text = "Failed to run hyprctl binds" }
        }
    end
    
    local modmask = ""
    local key = ""
    local description = ""
    while true do
        local line = handle:read()
        if line == nil then break end
        if line:match("^%s+modmask: ") then
            modmask = line
            modmask = string.gsub(modmask, "^%s+modmask: 0$", "")
            modmask = string.gsub(modmask, "^%s+modmask: 1$", "SHIFT ")
            modmask = string.gsub(modmask, "^%s+modmask: 4$", "CTRL ")
            modmask = string.gsub(modmask, "^%s+modmask: 5$", "SHIFT CTRL ")
            modmask = string.gsub(modmask, "^%s+modmask: 8$", "ALT ")
            modmask = string.gsub(modmask, "^%s+modmask: 9$", "SHIFT ALT")
            modmask = string.gsub(modmask, "^%s+modmask: 12$", "CTRL ALT")
            modmask = string.gsub(modmask, "^%s+modmask: 13$", "SHIFT CTRL ALT")
            modmask = string.gsub(modmask, "^%s+modmask: 64$", "SUPER ")
            modmask = string.gsub(modmask, "^%s+modmask: 65$", "SUPER SHIFT ")
            modmask = string.gsub(modmask, "^%s+modmask: 68$", "SUPER CTRL ")
            modmask = string.gsub(modmask, "^%s+modmask: 69$", "SUPER SHIFT CTRL ")
            modmask = string.gsub(modmask, "^%s+modmask: 72$", "SUPER ALT ")
            modmask = string.gsub(modmask, "^%s+modmask: 73$", "SUPER SHIFT ALT")
            modmask = string.gsub(modmask, "^%s+modmask: 76$", "SUPER CTRL ALT")
            modmask = string.gsub(modmask, "^%s+modmask: 77$", "SUPER SHIFT CTRL ALT")
        end

        if line:match("^%s+key: ") then
            key = string.sub(line, 7)
        end

        if line:match("^%s+description: ") then
            description = string.sub(line, 15)
        end
       
        if line == "" then
            if key ~= "" then
                local tmp = modmask .. key
                table.insert(entries, { Text = tmp, Subtext = description})
                modmask = ""
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
