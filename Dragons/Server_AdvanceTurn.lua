function Server_AdvanceTurn_Order(game, order, orderResult, skipThisOrder, addNewOrder)
	if order.proxyType == "GameOrderAttackTransfer" and orderResult.IsAttack then
        if #orderResult.ActualArmies.SpecialUnits > 0 then
            local dragonBreathDamage = 0;
            for _, sp in pairs(orderResult.ActualArmies.SpecialUnits) do
                if sp.proxyType == "CustomSpecialUnit" then
                    if sp.ModID ~= nil and sp.ModID == 594 and Mod.PublicGameData.DragonBreathAttack[Mod.PublicGameData.DragonNamesIDs[sp.Name]] ~= nil then
                        dragonBreathDamage = dragonBreathDamage + Mod.PublicGameData.DragonBreathAttack[Mod.PublicGameData.DragonNamesIDs[sp.Name]];
                    end
                end
            end
            if dragonBreathDamage > 0 then
                local mods = {};
                for connID, _ in pairs(game.Map.Territories[order.To].ConnectedTo) do
                    if game.ServerGame.LatestTurnStanding.Territories[connID].OwnerPlayerID ~= order.PlayerID then
                        local mod = WL.TerritoryModification.Create(connID);
                        mod.AddArmies = -math.min(game.ServerGame.LatestTurnStanding.Territories[connID].NumArmies.NumArmies, dragonBreathDamage);
                        if mod.AddArmies ~= 0 then
                            table.insert(mods, mod);
                        end
                    end
                end
                local event = WL.GameOrderEvent.Create(order.PlayerID, "Dragon breath", {}, mods);
                event.JumpToActionSpotOpt = WL.RectangleVM.Create(game.Map.Territories[order.To].MiddlePointX, game.Map.Territories[order.To].MiddlePointY, game.Map.Territories[order.To].MiddlePointX, game.Map.Territories[order.To].MiddlePointY)
                addNewOrder(event, true);
            end
            if not tableIsEmpty(orderResult.DamageToSpecialUnits) then
                local modTo = WL.TerritoryModification.Create(order.To);
                modTo.AddSpecialUnits = {};
                modTo.RemoveSpecialUnitsOpt = {};
                local modFrom = WL.TerritoryModification.Create(order.From);
                modFrom.AddSpecialUnits = {};
                modFrom.RemoveSpecialUnitsOpt = {};
                for ID, v in pairs(orderResult.DamageToSpecialUnits) do 
                    print(ID, v);
                    for _, sp in pairs(game.ServerGame.LatestTurnStanding.Territories[order.To].NumArmies.SpecialUnits) do
                        if sp.ID == ID then
                            if sp.ModID ~= nil and sp.ModID == 594 and Mod.PublicGameData.DynamicDefencePower ~= nil and Mod.PublicGameData.DynamicDefencePower[Mod.PublicGameData.DragonNamesIDs[sp.Name]] ~= nil then
                                modTo = replaceDragon(modTo, sp, v);
                            end
                            break;
                        end
                    end
                    for _, sp in pairs(game.ServerGame.LatestTurnStanding.Territories[order.From].NumArmies.SpecialUnits) do
                        if sp.ID == ID then
                            if sp.ModID ~= nil and sp.ModID == 594 and Mod.PublicGameData.DynamicDefencePower ~= nil and Mod.PublicGameData.DynamicDefencePower[Mod.PublicGameData.DragonNamesIDs[sp.Name]] ~= nil then
                                if orderResult.IsSuccessful then
                                    modTo = replaceDragon(modTo, sp, v);
                                else
                                    modFrom = replaceDragon(modFrom, sp, v);
                                end
                            end
                            break;
                        end
                    end
                end
                local mods = {};
                if #modTo.AddSpecialUnits > 0 then table.insert(mods, modTo); end
                if #modFrom.AddSpecialUnits > 0 then table.insert(mods, modFrom); end
                if #mods > 0 then
                    local event = WL.GameOrderEvent.Create(WL.PlayerID.Neutral, "Updated dragons", {}, mods);
                    event.JumpToActionSpotOpt = WL.RectangleVM.Create((game.Map.Territories[order.To].MiddlePointX + game.Map.Territories[order.From].MiddlePointX) / 2, (game.Map.Territories[order.To].MiddlePointY + game.Map.Territories[order.From].MiddlePointY) / 2, (game.Map.Territories[order.To].MiddlePointX + game.Map.Territories[order.From].MiddlePointX) / 2, (game.Map.Territories[order.To].MiddlePointY + game.Map.Territories[order.From].MiddlePointY) / 2);
                    addNewOrder(event, true);
                end
            end
        end
    end
end

function tableIsEmpty(t)
    for _, _ in pairs(t) do
        return false;
    end
    return true;
end

function replaceDragon(mod, sp, v)
    local builder = WL.CustomSpecialUnitBuilder.CreateCopy(sp);
    builder.Health = builder.Health - v;
    builder.DefensePower = builder.Health;
    local t = {};
    for _, v in pairs(mod.AddSpecialUnits) do
        table.insert(t, v);
    end
    table.insert(t, builder.Build());
    mod.AddSpecialUnits = t;
    t = {};
    for _, v in pairs(mod.RemoveSpecialUnitsOpt) do
        table.insert(t, v);
    end
    table.insert(t, sp.ID);
    mod.RemoveSpecialUnitsOpt = t;
    return mod;
end