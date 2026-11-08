local slugs = {
    [286090429] = "arsenal",
    [155615604] = "prisonlife"
}

local slug = slugs[game.PlaceId]
if not slug then
    warn("Game not supported")
    return
end

local api = loadstring(game:HttpGet("https://auth.hungquan99.lol/sdk/library.lua"))()
api.script_id = slug

local messages = {
    KEY_EMPTY = "Please enter a key.",
    KEY_INCORRECT = "Invalid key.",
    KEY_EXPIRED = "This key has expired.",
    KEY_DISABLED = "This key was disabled.",
    KEY_PAUSED = "This key is paused.",
    KEY_BLACKLISTED = "This key is blacklisted.",
    KEY_HWID_LOCKED = "Key is locked to another device. Reset your HWID first.",
    SCRIPT_UNAVAILABLE = "Script is currently unavailable.",
    HWID_UNAVAILABLE = "Your executor does not provide a HWID.",
    HTTP_UNAVAILABLE = "Your executor has no HTTP request function.",
    NETWORK_ERROR = "Could not reach the server.",
    RATE_LIMITED = "Too many checks. Wait a moment.",
    SERVER_ERROR = "Server error. Try again later."
}

local Ophyn = loadstring(game:HttpGet("https://ophyn.space/interface"))()

Ophyn:SetGetkeyTitle("Get Key")

Ophyn.new({
    Title = "Zero.gg Key",
    Description = "Key System",
    Theme = "Midnight",
    Folder = "Zero-Key",
    getkey = true,
    ChangeTheme = "false",
    NotifStyle = "1",
    discord_link = "discord.gg/Ve8xjGzGG4",
    Discord = "true",
    Website = "false",
    SupportedGames = {
        [286090429] = true,
        [155615604] = true
    },
    KeySystem = {
        URL = "https://discord.gg/Ve8xjGzGG4",
        SaveKey = false,
        Key = function(key)
            key = tostring(key or ""):gsub("%s+", "")
            if key == "" then
                return false, messages.KEY_EMPTY
            end

            local ok, result = pcall(api.check_key, key)
            if not ok or type(result) ~= "table" then
                return false, "Check failed. Try again."
            end

            if result.code == "KEY_VALID" or result.code == "KEYLESS" then
                return true
            end

            return false, messages[result.code] or (tostring(result.code) .. ": " .. tostring(result.message))
        end
    },
    Callback = function(key)
        key = tostring(key or ""):gsub("%s+", "")
        getgenv().script_key = key
        api.load_script(key)
    end
})
