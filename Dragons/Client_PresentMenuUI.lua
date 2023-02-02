require("UI");
function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)
	if game.Settings.SinglePlayer then
        UI.Alert("This option can only be used in singleplayer");
        close();
        return;
    end
    Init(rootParent);
    root = GetRoot();
    colors = GetColors();
    Game = game;

    showMain();
end

function showMain()
    DestroyWindow();
    SetWindow("Main");
    
    CreateButton(root).SetText("Place Dragon").setColor(colors.Lime).SetOnClick(pickTerr);

    CreateEmpty(root).SetPreferredHeight(10);

    CreateLabel(root).SetText("These are all the Dragons that will be placed (note that you still have to copy the data input over to the mod settings!)").SetColor(colors.Textcolor);
    for terr, arr in pairs(Mod.PublicGameData.DragonPlacements) do
        for _, dragonID in pairs(arr) do
            local line = CreateHorz(root);
            local s = "";
            if Mod.Settings.Dragons[dragonID].IncludeABeforeName then
                s = s .. "A ";
            end
            CreateLabel(line).SetText(s .. Mod.Settings.Dragons[dragonID].Name .. " on: ").SetColor(Mod.Settings.Dragons[dragonID].Color);
            CreateButton(line).SetText(Game.Map.Territories[terr]).SetColor(colors.Tan).SetOnClick(function()  end);
        end
    end
end

function pickTerr()
    DestroyWindow();
    SetWindow("pickTerr");

    CreateButton(root).SetText("Return").setColor(colors.Orange).SetOnClick(showMain);
    label = CreateLabel(root).SetText("click / tap a territory to deploy a Dragon").setColor(colors.Textcolor);
    local line = CreateHorz(root);
    nextButton = CreateButton(line).SetText("Next").setColor(colors.Green).SetOnClick(chooseDragon).SetInteractable(false);
    againButton CreateButton(line).SetText("Change territory").setColor(colors["Royal Blue"]).SetOnClick(function() UI.InterceptNextTerritoryClick(terrChosen); end).SetInteractable(false);
    UI.InterceptNextTerritoryClick(terrChosen)
end

function terrChosen(terrDetails)
    if terrDetails ~= nil then
        chosenTerr = terrDetails;
        label.SetText("Territory chosen: " .. terrDetails.Name);
        nextButton.SetInteractable(true);
        againButton.SetInteractable(true);
    end
end

function chooseDragon()
    DestroyWindow();
    SetWindow("chooseDragon");

    CreateButton(root).SetText("Return").setColor(colors.Orange).SetOnClick(pickTerr);
    CreateEmpty(root).SetPreferredHeight(10);
    CreateLabel(root).SetText("Choose which dragon will be put on " .. chosenTerr.Name);
    CreateEmpty(root).SetPreferredHeight(5);

    for _, dragon in ipairs(Mod.Settings.Dragons) do
        CreateButton(root).SetText(dragon.Name).SetColor(dragon.Color).SetOnClick(function() addDragon(dragon.ID) end);
    end
end

function addDragon(dragonID)
    Game.SendGameCustomMessage("Updating data...", {Type="addDragon", TerrID=chosenTerr.ID, DragonID=dragonID}, function(t) showMain(); end);
    Close();
end