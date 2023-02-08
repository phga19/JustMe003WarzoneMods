function Server_Created(game, settings)
	data = Mod.PublicGameData;
    data.Errors = {};
    local s = Mod.Settings.DragonPlacements
    local start, ending = s:find("%[[%d]+%]");
    local mapID = nil;
    if #s > 0 then
        mapID = tonumber(s:sub(start + 1, ending - 1));
        s = s:sub(ending + 2, -1);
        data.DragonPlacements = getTable(s);
        if data.DragonPlacements == nil then data.DragonPlacements = {}; end
    end
    if data.DragonPlacements == nil then
        data.DragonPlacements = {};
    end
    if mapID == nil or game.Map.ID ~= mapID then
        table.insert(data.Errors, "The map does not correspond to the inputted data, please update the data and try again");
    end
    data.DragonNamesIDs = {};
    data.DragonBreathAttack = {};
    for _, dragon in pairs(Mod.Settings.Dragons) do
        data.DragonNamesIDs[dragon.Name] = dragon.ID;
        if dragon.DragonBreathAttack then
            data.DragonBreathAttack[dragon.ID] = dragon.DragonBreathAttackDamage;
        end
    end
    Mod.PublicGameData = data;
end

function getTable(s)
    local t = {};
    local key = nil;
    while #s > 0 do
        local nextChar = s:sub(1, 1);
        if nextChar == "}" then
            return t, s:sub(2, -1);
        elseif nextChar == "," then
            s = s:sub(2, -1);
        else
            local start, ending = s:find("%w+");
            if start ~= nil and ending ~= nil then
                local commandChar = s:sub(ending + 1, ending + 1);
                if commandChar == ":" then
                    key = getCorrectType(s:sub(start, ending));
                    if key == nil then
                        table.insert(data.Errors, "The inputted data didn't have the right format. DO NOT CHANGE ANYTHING MANUALLY TO THE INPUT DATA. If you didn't, please let me know so I can fix it.")
                        return t, "";
                    end
                    s = s:sub(ending + 2, -1);
                    local valueChar = s:sub(1, 1);
                    if valueChar == "{" then
                        t[key], s = getTable(s:sub(2, -1));
                    else
                        start, ending = s:find("%w+");
                        local value = getCorrectType(s:sub(start, ending));
                        if value ~= nil then
                            t[key] = value;
                            s = s:sub(ending + 1, -1);
                        else
                            table.insert(data.Errors, "The inputted data didn't have the right format. DO NOT CHANGE ANYTHING MANUALLY TO THE INPUT DATA. If you didn't, please let me know so I can fix it.")
                            return t, "";
                        end
                    end
                else
                    local value = getCorrectType(s:sub(start, ending));
                    if value == nil then
                        table.insert(data.Errors, "The inputted data didn't have the right format. DO NOT CHANGE ANYTHING MANUALLY TO THE INPUT DATA. If you didn't, please let me know so I can fix it.")
                        return t, "";
                    end
                    table.insert(t, value);
                    s = s:sub(ending + 1, -1);
                end
            else
                table.insert(data.Errors, "The inputted data didn't have the right format. DO NOT CHANGE ANYTHING MANUALLY TO THE INPUT DATA. If you didn't, please let me know so I can fix it.")
                return t, "";
            end
        end
    end
    return t, s;
end

function getCorrectType(input)
    if input == nil then
        return nil;
    elseif tonumber(input) ~= nil then
        return tonumber(input);
    end
    return input;
end

function printCompleteTable(t)
    for i, v in pairs(t) do
        print(i, v);
        if type(v) == type({}) then
            printCompleteTable(v);
        end
    end
end