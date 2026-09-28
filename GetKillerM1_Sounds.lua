-----------------------------
-- NEW
-----------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local function exportKillerSounds()
    local finalTable = "local KillerM1Sounds = {\n"
    
    -- Вспомогательная функция для вытаскивания ID из любого формата
    local function getID(value)
        if type(value) == "string" then
            return value
        elseif type(value) == "table" then
            if value.SoundId then return value.SoundId end
            if value.ID then return value.ID end
            -- Если это просто список (как у Sixer), берем первый элемент
            if value[1] then return getID(value[1]) end
        end
        return nil
    end

    for _, killerFolder in ipairs(Assets.Killers:GetChildren()) do
        local killerName = killerFolder.Name
        local soundIds = {}

        local function collectFromConfig(config)
            if not config or not config.Sounds then return end
            local s = config.Sounds

            -- Собираем только звуки обычных взмахов/ударов (M1)
            local m1Keys = {
                "Swing", 
                "SlashGround", 
                "Lacerate", 
                "Slash", 
                "Attack", 
                "HitAir"
            }
            
            for _, key in ipairs(m1Keys) do
                local soundId = getID(s[key])
                if soundId then 
                    table.insert(soundIds, soundId) 
                end
            end
        end

        local success, config = pcall(function() return require(killerFolder:FindFirstChild("Config")) end)
        if success then collectFromConfig(config) end

        local skinsFolder = Assets.Skins.Killers:FindFirstChild(killerName)
        if skinsFolder then
            for _, skin in ipairs(skinsFolder:GetChildren()) do
                local sSuccess, sConfig = pcall(function() return require(skin:FindFirstChild("Config")) end)
                if sSuccess then collectFromConfig(sConfig) end
            end
        end

        if #soundIds > 0 then
            local uniqueIds = {}
            local hash = {}
            for _, id in ipairs(soundIds) do
                if id and not hash[id] and tostring(id):find("rbxassetid") then
                    table.insert(uniqueIds, id)
                    hash[id] = true
                end
            end

            if #uniqueIds > 0 then
                local formattedName = killerName:find("^%d") and '["' .. killerName .. '"]' or killerName
                finalTable = finalTable .. "    " .. formattedName .. " = {"
                for i, id in ipairs(uniqueIds) do
                    finalTable = finalTable .. '"' .. tostring(id) .. '"' .. (i < #uniqueIds and ", " or "")
                end
                finalTable = finalTable .. "},\n"
            end
        end
    end

    finalTable = finalTable .. "}"
    print(finalTable)
    if setclipboard then setclipboard(finalTable) end
end

exportKillerSounds()

-----------------------------
-- OLD ABILITY
-----------------------------

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local function exportKillerSounds()
    local finalTable = "local KillerRushSounds = {\n"
    
    -- Вспомогательная функция для вытаскивания ID из любого формата
    local function getID(value)
        if type(value) == "string" then
            return value
        elseif type(value) == "table" then
            if value.SoundId then return value.SoundId end
            if value.ID then return value.ID end
            -- Если это просто список (как у Sixer), берем первый элемент
            if value[1] then return getID(value[1]) end
        end
        return nil
    end

    for _, killerFolder in ipairs(Assets.Killers:GetChildren()) do
        local killerName = killerFolder.Name
        local soundIds = {}

        local function collectFromConfig(config)
            if not config or not config.Sounds then return end
            local s = config.Sounds

            -- 1. Сбор звуков взмаха (учитываем разные названия ключей)
            local swingSound = getID(s.Swing) or getID(s.SlashGround) or getID(s.Lacerate)
            if swingSound then table.insert(soundIds, swingSound) end

            -- 2. Рывок Noli (VoidRush)
            if killerName == "Noli" then
                if s.VoidRushLoop then table.insert(soundIds, getID(s.VoidRushLoop)) end
            
            -- 3. Рывок c00lkidd (WalkspeedOverride)
            elseif killerName == "c00lkidd" then
                if s.WalkspeedOverrideLoop then table.insert(soundIds, getID(s.WalkspeedOverrideLoop)) end
            
            -- 5. Рывок Sixer (DemonicPursuit)
            elseif killerName == "Sixer" then
                if s.DemonicPursuitLunge then table.insert(soundIds, getID(s.DemonicPursuitLunge)) end
            end
        end

        local success, config = pcall(function() return require(killerFolder:FindFirstChild("Config")) end)
        if success then collectFromConfig(config) end

        local skinsFolder = Assets.Skins.Killers:FindFirstChild(killerName)
        if skinsFolder then
            for _, skin in ipairs(skinsFolder:GetChildren()) do
                local sSuccess, sConfig = pcall(function() return require(skin:FindFirstChild("Config")) end)
                if sSuccess then collectFromConfig(sConfig) end
            end
        end

        if #soundIds > 0 then
            local uniqueIds = {}
            local hash = {}
            for _, id in ipairs(soundIds) do
                if id and not hash[id] and tostring(id):find("rbxassetid") then
                    table.insert(uniqueIds, id)
                    hash[id] = true
                end
            end

            if #uniqueIds > 0 then
                local formattedName = killerName:find("^%d") and '["' .. killerName .. '"]' or killerName
                finalTable = finalTable .. "    " .. formattedName .. " = {"
                for i, id in ipairs(uniqueIds) do
                    finalTable = finalTable .. '"' .. tostring(id) .. '"' .. (i < #uniqueIds and ", " or "")
                end
                finalTable = finalTable .. "},\n"
            end
        end
    end

    finalTable = finalTable .. "}"
    print(finalTable)
    if setclipboard then setclipboard(finalTable) end
end

exportKillerSounds()





-----------------------------
-- NEW
-----------------------------
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = ReplicatedStorage:WaitForChild("Assets")

local function exportKillerSounds()
    local finalTable = "local KillerM1Sounds = {\n"
    
    -- Вспомогательная функция для вытаскивания ID из любого формата
    local function getID(value)
        if type(value) == "string" then
            return value
        elseif type(value) == "table" then
            if value.SoundId then return value.SoundId end
            if value.ID then return value.ID end
            -- Если это просто список (как у Sixer), берем первый элемент
            if value[1] then return getID(value[1]) end
        end
        return nil
    end

    for _, killerFolder in ipairs(Assets.Killers:GetChildren()) do
        local killerName = killerFolder.Name
        local soundIds = {}

        local function collectFromConfig(config)
            if not config or not config.Sounds then return end
            local s = config.Sounds

            -- Собираем только звуки обычных взмахов/ударов (M1)
            local m1Keys = {
                "Swing", 
                "Slash", 
            }
            
            for _, key in ipairs(m1Keys) do
                local soundId = getID(s[key])
                if soundId then 
                    table.insert(soundIds, soundId) 
                end
            end
        end

        local success, config = pcall(function() return require(killerFolder:FindFirstChild("Config")) end)
        if success then collectFromConfig(config) end

        local skinsFolder = Assets.Skins.Killers:FindFirstChild(killerName)
        if skinsFolder then
            for _, skin in ipairs(skinsFolder:GetChildren()) do
                local sSuccess, sConfig = pcall(function() return require(skin:FindFirstChild("Config")) end)
                if sSuccess then collectFromConfig(sConfig) end
            end
        end

        if #soundIds > 0 then
            local uniqueIds = {}
            local hash = {}
            for _, id in ipairs(soundIds) do
                if id and not hash[id] and tostring(id):find("rbxassetid") then
                    table.insert(uniqueIds, id)
                    hash[id] = true
                end
            end

            if #uniqueIds > 0 then
                local formattedName = killerName:find("^%d") and '["' .. killerName .. '"]' or killerName
                finalTable = finalTable .. "    " .. formattedName .. " = {"
                for i, id in ipairs(uniqueIds) do
                    finalTable = finalTable .. '"' .. tostring(id) .. '"' .. (i < #uniqueIds and ", " or "")
                end
                finalTable = finalTable .. "},\n"
            end
        end
    end

    finalTable = finalTable .. "}"
    print(finalTable)
    if setclipboard then setclipboard(finalTable) end
end

exportKillerSounds()



ПЕРЕОБРАЗОВАТОР ЗВУКОВ

local KillerM1Sounds = {
    c00lkidd = {"rbxassetid://80516583309685", "rbxassetid://128195973631079", "rbxassetid://79391273191671", "rbxassetid://75330693422988", "rbxassetid://82221759983649", "rbxassetid://84307400688050", "rbxassetid://102228729296384", "rbxassetid://113055337526374"},
    JohnDoe = {"rbxassetid://140242176732868", "rbxassetid://86174610237192", "rbxassetid://131123355704017", "rbxassetid://105204810054381", "rbxassetid://98675142200448"},
    Noli = {"rbxassetid://109348678063422", "rbxassetid://89004992452376", "rbxassetid://136323728355613", "rbxassetid://112395455254818", "rbxassetid://108610718831698", "rbxassetid://128367348686124", "rbxassetid://114742322778642", "rbxassetid://131406927389838"},
    Slasher_FRIDAY = {"rbxassetid://112809109188560"},
    Sixer = {"rbxassetid://119583605486352", "rbxassetid://71805956520207", "rbxassetid://117231507259853", "rbxassetid://127557531826290", "rbxassetid://96594507550917"},
    JohnDoe_MARCH = {"rbxassetid://106836941416453"},
    ["1x1x1x1"] = {"rbxassetid://117173212095661", "rbxassetid://85853080745515", "rbxassetid://101199185291628", "rbxassetid://95079963655241", "rbxassetid://119942598489800", "rbxassetid://98111231282218", "rbxassetid://115026634746636", "rbxassetid://121954639447247", "rbxassetid://119089145505438", "rbxassetid://128856426573270", "rbxassetid://74809026448465"},
    ShedletskyFunny = {"rbxassetid://117173212095661"},
    Slasher = {"rbxassetid://112809109188560", "rbxassetid://105840448036441", "rbxassetid://116581754553533", "rbxassetid://108907358619313", "rbxassetid://107444859834748", "rbxassetid://94317217837143", "rbxassetid://124903763333174", "rbxassetid://116468089135195", "rbxassetid://120749612844426"},
    Jason = {"rbxassetid://112809109188560", "rbxassetid://108907358619313", "rbxassetid://12222216"},
}

104910828105172 -- SlashGround

local AutoBlockTriggerSounds = {}

for _, soundList in pairs(KillerM1Sounds) do
    for _, soundId in pairs(soundList) do
        local id = soundId:match("%d+")
        if id then
            AutoBlockTriggerSounds[id] = true
        end
    end
end

-- Генерация строки для копирования
local output = "local AutoBlockTriggerSounds = {\n"
for id, val in pairs(AutoBlockTriggerSounds) do
    output = output .. '    ["' .. id .. '"] = true, \n'
end
output = output .. "}"

setclipboard(output)
print("Готово! Таблица скопирована в буфер обмена.")



local KillerM1Sounds = {
    c00lkidd = {"rbxassetid://80516583309685", "rbxassetid://128195973631079", "rbxassetid://79391273191671", "rbxassetid://75330693422988", "rbxassetid://82221759983649", "rbxassetid://84307400688050", "rbxassetid://102228729296384", "rbxassetid://113055337526374"},
    JohnDoe = {"rbxassetid://140242176732868", "rbxassetid://86174610237192", "rbxassetid://131123355704017", "rbxassetid://105204810054381", "rbxassetid://98675142200448"},
    SlasherSwift = {"rbxassetid://112809109188560"},
    Noli = {"rbxassetid://109348678063422", "rbxassetid://89004992452376", "rbxassetid://136323728355613", "rbxassetid://112395455254818", "rbxassetid://108610718831698", "rbxassetid://128367348686124", "rbxassetid://114742322778642", "rbxassetid://131406927389838"},
    !Slasher_FRIDAY = {"rbxassetid://112809109188560"},
    !Erlking = {"rbxassetid://106368806396221"},
    !Herobrine = {"rbxassetid://83336588073857"},
    !Sancho = {"rbxassetid://129697992204296"},
    !SukunaKiller = {"rbxassetid://12222216"},
    Sixer = {"rbxassetid://119583605486352", "rbxassetid://71805956520207", "rbxassetid://117231507259853", "rbxassetid://127557531826290", "rbxassetid://96594507550917"},
    !Fog = {"rbxassetid://12222208"},
    !DoppelgangerShedletsky = {"rbxassetid://12222208"},
    !JohnDoe_MARCH = {"rbxassetid://106836941416453"},
    ["1x1x1x1"] = {"rbxassetid://117173212095661", "rbxassetid://85853080745515", "rbxassetid://101199185291628", "rbxassetid://95079963655241", "rbxassetid://119942598489800", "rbxassetid://98111231282218", "rbxassetid://115026634746636", "rbxassetid://121954639447247", "rbxassetid://119089145505438", "rbxassetid://128856426573270", "rbxassetid://74809026448465"},
    ShedletskyFunny = {"rbxassetid://117173212095661"},
    Slasher = {"rbxassetid://112809109188560", "rbxassetid://105840448036441", "rbxassetid://116581754553533", "rbxassetid://108907358619313", "rbxassetid://107444859834748", "rbxassetid://94317217837143", "rbxassetid://124903763333174", "rbxassetid://116468089135195", "rbxassetid://120749612844426"},
    Jason = {"rbxassetid://112809109188560", "rbxassetid://108907358619313", "rbxassetid://12222216"},
    !Azure = {"rbxassetid://82843272472677"},
}