require("utilities");

function Client_GameRefresh(Game)
	game = Game;
	if game.Us == nil then return; end
	local playerData = Mod.PlayerGameData;
	if playerData.LastTurnSinceMessage == nil then playerData.LastTurnSinceMessage = game.Game.TurnNumber; end
	if game.Game.TurnNumber > 0 then
		print(playerData.LastTurnSinceMessage, playerShouldPick(game.Us.ID), game.Game.TurnNumber, data.DurationDistributionStage);
		if playerShouldPick(game.Us.ID) and game.Game.TurnNumber <= data.DurationDistributionStage and game.Game.TurnNumber > playerData.LastTurnSinceMessage then
			UI.Alert("In this turn you're able to pick 1 more territory. Open the Extended Distribution Phase mod menu to pick");
			playerData.LastTurnSinceMessage = game.Game.TurnNumber;
		end
	end
	if (game.Game.TurnNumber - 1 == data.DurationDistributionStage or data.AbortDistribution) and Mod.PlayerGameData.hasSeenPlayMessage ~= nil then
		UI.Alert("From this turn the game will advance normally again, any picks made will get ignored")
		playerData.hasPlayeenMessage = true
	end
	Mod.PlayerGameData = playerData;
end


function playerShouldPick(PlayerID)
	if Mod.Settings.numberOfGroups == 1 then return true; end
	return valueInTable(Mod.PublicGameData.Groups[getGroup(game.Game.TurnNumber, Mod.PublicGameData.numberOfGroups)], PlayerID);
end