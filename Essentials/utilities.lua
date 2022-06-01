function getMods()
	return {"Essentials", "Buy Neutral", "Diplomacy", "Gift Armies", "Gift Gold", "Picks Swap", "Randomized Bonuses", "Randomized Wastelands", "Advanced Diplo Mod V4", "AIs don't deploy", "Buy Cards", "Commerce Plus", "Custom Card Package", "Diplomacy 2", "Late Airlifts", "Limited Attacks", "Limited Multiattacks", "Neutral Moves", "Safe Start", "Swap Territories", "Take Turns", "AI's don't play cards", "Better don't fail an attack", "Bonus Airlift", "BonusValue QuickOverrider", "Capture The Flag", "Connected Commanders", "Decoy Card", "Deployment Limit", "Don't lose a territory", "Extended Randomized Bonuses", "Extended Winning Conditions", "Forts", "Gift Armies 2", "Highest Income Disadvantage", "Hybrid Distribution", "Hybrid Distribution 2", "Infromations for spectaters", "King of the Hills", "Local Deployment Helper", "Lotto Mod -> Instant Random Winner", "More_Distributions", "One Way Connections", "Portals", "Press This Button", "Random Starting Cities", "Reversed Bonus Armies Per Territory", "Runtime Wastelands", "Spawnbarriers", "Special units are Medics", "Stack Limit", "Transport Only Airlift"}
end

function getStatus(mod)
	local index;
	for i, v in pairs(getMods()) do if mod == v then index = i; break; end end
	if index <= 7 then 
		return "trusted"; 
	elseif index <= 20 then 
		return "standard"; 
	else 
		return "experimental"; 
	end
end

function getContents(path)
	local indexes = split(path, "/")
	local ret = mods;
	for _, i in pairs(indexes) do
		ret = ret[i];
		if ret == nil then return nil; end
	end
	return ret;
end


function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function getTableLength(t)
	local count = 0;
	for i, _ in pairs(t) do
		count = count + 1;
	end
	return count;
end


function getBugs()
	local t = {};
	for i, _ in pairs(mods) do
		t[i] = mods[i]["Bugs"];
	end
	return t;
end

function getBugFreeMessage()
	return "This mod is bug free as far as I know. If you do find a bug please send the mod creator or me a message with the following:\n -  A description of the bug\n -  The link to the game\n\nJust_A_Dutchman_: (https://www.warzone.com/Discussion/SendMail?PlayerID=1311724)";
end

function initManuals()
	local bugFreeMessage = getBugFreeMessage();
	local compatibilityAllMessage = "This mod can be used with every other mod / setting in Warzone. If you do find something please send me a message with the following:\n -  A description of what happened or should have happened\n -  The link to the game\n - The turn number where it happened\n\nJust_A_Dutchman_: (https://www.warzone.com/Discussion/SendMail?PlayerID=1311724)";
	mods = {};
	mods["Essentials"] = {};
	mods["Essentials"]["Mod menu"] = "One property a lot of mods make use of is a mod menu. A menu is mostly used to get input from the player, process the input and do something according to the input (give gold to a certain player, send an alliance request or create a new window to ask for more input).";
	mods["Essentials"]["Order list"] = "(almost) everything that happens is an order. The most important thing you need to know is that mods are able to add orders in your order list / the history. There are many types of orders that can happen, the most frequently used being:\n\n - GameOrderDeploy (deployment)\n - GameOrderAttackTransfer (an attack or transfer)\n - GameOrderPlayCard (using a card)\n - GameOrderReceiveCard (receiving card pieces at the end of the turn)\n - GameOrderEvent (a custom order event that mods are able to use)\n\nMods are obliged to create a game order when they change something in the standing after the distribution turns. This way you shouldn't have to wonder what happened when you watch a turn / history. They mostly use the GameOrderEvent for this, since this order can be anything they want. Just like other orders you can move them up and down in your order list before you submit your turn. \n\nNote that most orders added by mods are from a different order type, the GameOrderCustom type. You can use these orders to your advantage since they don't have a specific place where they are processed in a turn, except if the mod forces them to. But you should always try to place them somewhere in your orderlist where you want them, to gain the most advantage out of them.";
	mods["Essentials"]["Turns"] = "A turn consists of a standing and an order list, containing all orders of the individual players, ordered following the move order. Some mods make modifications to the standing when a condition is met, eg. add armies to a territory, set the territory to neutral or even cancel the order that triggered the condition. In the last case it is not always the case that an order gets added to the order list, telling you the order has been skipped.";
	mods["Essentials"]["Standing"] = "A standing works together with the map to show you all the details of the state of the game. Every turn in history has a different standing, even the distribution turn.\nA standing keeps track of a few things:\n\n - The active cards\n - All the cards each player has\n - All the territory details (who owns the territory, with how many armies and/or special units and what type of fog level)\n\nThe map knows which territories are in each bonus and knows where the territories are, but it needs a standing to show who owns the territory and with which special unit(s) and armies.";
	mods["Essentials"]["Mod configuration"] = "Almost all mods have a mod configuration. When you add the mod to the game it will fold out the mod description and (optional) some mod settings. You can alter settings or specify how the mod should behave here. In the example below (See contact for the link to the document, with the example. mod: Connected Commanders) you can specify if commanders can transfer, can attack and how many commanders each player gets at turn 1.";
	mods["Essentials"]["Mod settings"] = "Every mod with custom settings should display these settings when the player reads the full settings page. This settings display should be enough for players to know what the settings are of the game so they can adapt their play style for it if necessary.";
	mods["Essentials"]["Input and output"] = {};
	mods["Essentials"]["Input and output"]["Labels"] = "Labels are the standard way of showing text to the user, it does not have another function. Labels do have properties that can change. So can a mod modify the text and change the color.";
	mods["Essentials"]["Input and output"]["Buttons"] = "Buttons are an easy way to let the user interact with the UI (User Interface). When the user presses the button the mod can do stuff accordingly. This mod for example lets you browse around using only buttons. But other examples are adding (an) order(s) to your orderlist or sending a message to the Warzone server with information it needs.";
	mods["Essentials"]["Input and output"]["Checkboxes"] = "Checkboxes are simple to use and have quite the functionality. A checkbox can either be checked (true) or unchecked (false). This is really useful in UI, for example in mod configurations. When you click the checkbox to (un)check it, it might even do something. In most cases it modifies some text from a label or (un)check another checkbox.";
	mods["Essentials"]["Input and output"]["Number input fields"] = "Number input fields used a lot in mod configurations. These input fiels allow the user to input or adjust a number, and only a number. Text can not be inputted here. Inputting or adjusting a number of a number input field will never do something else, like modifying text from a label.";
	mods["Essentials"]["Input and output"]["Text input fields"] = "Text input fields are one of the least used input / output objects. But that aside, it is still really usefull to know how they work and what they're for. These input fields take any character as input, so they're useful in many ways. Text input fields also are the only way to copy text into your clipboard on all platforms. The most known usage of them is in the BetterCities and Groupchat mod.";
	mods["Essentials"]["Input and output"]["Alerts"] = "Alerts are the pop ups you get when configuring a mod wrong, or when the mod wants to give you really important information. They are really useful since the user always gets to see them. Alerts can only be closed and do not have another feature than informing the users.";
	mods["Essentials"]["Input and output"]["List prompt"] = "This input method is really useful as well, although using it as user sometimes is really tedious. This method gives the user a list of options it must choose one of, or cancel the action. It is used in Diplomacy mods to pick players and in Custom Card Package to pick a territory for the Nuke card. In the last example, playing on big maps resulted in a list that can have 3000+ options to choose from. This is because a better implementation for this only exists since Warzone 5.17";
	mods["Essentials"]["Input and output"]["Intercept territory click"] = "This is a relative new method, since Warzone 5.17. When a mod uses this method it can detect when the player clicks on a territory. This is a far better implementation than List prompt, the old way to do it.";
	mods["Essentials"]["Input and output"]["Intercept bonuslink click"] = "This is a relative new method, since Warzone 5.17. When a mod uses this method it can detect when the player clicks on a bonuslink. This is a far better implementation than List prompt, the old way to do it, although not every bonus has a bonuslink to click on.";
	mods["Buy Neutral"] = {};
	mods["Buy Neutral"]["Mod description"] = "Allows players to purchase neutral territories with gold rather than conquering them by force. Requires that the game is a commerce game, and will do nothing otherwise. \n\nThe game creator can configure how expensive territories are to purchase, based on how many armies are on the neutral territory. To initiate a purchase, click the button for the mod on the menu, select the territory, and a purchase order will be inserted into your orders list. The purchase will complete when the turn advances.";
	mods["Buy Neutral"]["How to use"] = "This mod allows players to buy neutral territories with gold, the price of the territory is determined by the amount of armies and the multiplier configured by the game creator.\n\nThere are some things you should know before you start asking questions. The most notable thing you should know is that only territories you can fully see are purchasable. When playing with light or dense (also heavy) fog you will be able to see who owns the territory, but not the army count and which special units. The mod sees this as ‘not fully visible’ and these territories are not purchasable. To buy a territory in light, dense or heavy fog that is not fully visible, you should play a reconnaissance, surveillance or spy (only if you’re able to spy on neutral) card.\n\nSecond, when you add the order to buy a territory does not mean you will buy the territory for sure. When the turn advances, the mod will look at every purchase order and check if the territory is still neutral. If the territory is not neutral anymore at the time your purchase order gets processed, nothing will happen. Note that the purchase order type is GameOrderCustom, you can put these orders wherever you want in your order list. You can even put them before your deployment orders where they will get processed before any deployment orders, even those of your opponents.\n\nThird, the amount of armies on the neutral territory can differ at the time your purchase order gets processed then when you added the order in your order list. If the amount of armies on the territory is more than you originally paid for your purchase will get canceled. If the amount of armies is less than you originally paid for and the territory is still neutral, you will buy the territory but won’t get any compensation for paying too much.\n\nAt last, when playing on a big map, with a lot of neutral territories and no fog, the list where you can choose the territories from will be really, really big. Creating the list will take a while and searching for a precise territory is a task which requires a lot of patience. In this case I strongly recommend using the browser version to submit your turn. You can use [ctrl] + [F] to search for the name of the territory in the list which is way easier and faster than looking at every possible territory in the list. Note you cannot add these orders in the browser and finish creating your orders on mobile or in the app since the purchase orders will not be stored on the browser. The other way around is possible though.";
	mods["Buy Neutral"]["How to set up"] = "When you add this mod you have to make sure you enable commerce, otherwise the mod won’t do anything and players won’t be able to create purchase orders at all.\n\nAlso be careful with the multiplier. When you set the multiplier to high, buying neutrals will get extremely inefficiënt but setting it to low, it becomes extremely efficiënt. The bare minimum in my opinion is 1, although it is possible to set it to 0. But by doing so you will give players the possibility to buy every territory they can fully see for free, resulting in a massive auction where the players who know what is listed above (how to use) will get a massive advantage.";
	mods["Buy Neutral"]["Bugs"] = bugFreeMessage;
	mods["Buy Neutral"]["Compatibility"] = "This mod is compatible with every setting, but does need the game to be a commerce game to allow the mod to be actually used. Nevertheless this mod lacks some useful features and really needs an update or revamp.";
	mods["Diplomacy"] = {};
	mods["Diplomacy"]["Mod description"] = "Allows players to make alliances with each other. All alliances made are public -- to view them, open the diplomacy mod from the game's menu. \n\nTo propose an alliance, click Propose and select the player and number of turns to make the alliance for. If they accept, both players will be unable to attack the other until it expires.";
	mods["Diplomacy"]["How to use"] = "The Diplomacy mod is a great utility mod for diplo and FFA games. Players can propose alliances to other players, which can on their turn accept or deny them. Whenever an alliance is accepted it is made public and all alliances can be found in the mod menu.\n\nTo propose an alliance you have to open the mod menu and click the Propose alliance button. It will open another window that will ask you to enter more inputs. You can specify to whom you want to send the proposal by clicking the Select player button. Thereafter you can alter the duration of the alliance using the number input field or slider.\n\nYou cannot attack allied players and allied players cannot attack you. If you do want to attack an allied player you have to wait the alliance out. Therefore I recommend not making alliances for 20+ turns since you’re likely going to regret this decision.";
	mods["Diplomacy"]["How to set up"] = "Adding this mod to the game is enough to play with this mod. The mod does not need any specific settings and can be used in any game.";
	mods["Diplomacy"]["Bugs"] = bugFreeMessage;
	mods["Diplomacy"]["Compatibility"] = "This mod is compatible with every mod, although I recommend not to use it with one of the other diplomacy mods (Advanced Diplo mod V4 and Diplomacy 2). It might cause confusion when two diplomacy mods are used in a game";
	mods["Gift Armies"] = {};
	mods["Gift Armies"]["Mod description"] = "Allows players to gift armies to another player, friend or foe. Armies you give will be distributed to random territories throughout the opponent's empire.\n\nTo use it, select Gift Armies from the game's menu, select a territory you wish to give armies from, how many armies to give, and which player you wish to give them to.";
	mods["Gift Armies"]["How to use"] = "This mod allows players to give armies away to other players. This can be useful in many games, mostly those that have alliances or teams.\n\nTo give armies to some player you must open the mod menu. Here you can specify which player will receive your armies and from which territory they will be taken from. Once you’ve selected a source territory a number input field and slider will pop up. The number shown in the number input field will be the amount of armies that you will give away. Once you think you’re done you can click the Gift button all the way at the bottom of the window. This will create a custom order that you can remove in case you changed your mind or made a mistake setting up the order.\n\nNote that all the gifted armies are randomly distributed on the territories of the player you send them to. \n\nWhen the turn advances your orders will get processed. For the gift orders there is no wrong place to put them. When you add a gift order they will get added all the way at the end but if you want you can move them before your deployments, meaning your gifts will go through first before any deployments are made.";
	mods["Gift Armies"]["How to set up"] = "Adding this mod to the game is enough to play with this mod. The mod does not need any specific settings and can be used in any game.";
	mods["Gift Armies"]["Bugs"] = bugFreeMessage;
	mods["Gift Armies"]["Compatibility"] = "This mod is compatible with every other mod, except for the Decoy Card mod. The combination of these mods provide a massive exploit that players can use to create millions of armies."
	mods["Gift Gold"] = {};
	mods["Gift Gold"]["Mod description"] = "Allows players to gift gold to another player in commerce games, friend or foe. This mod should only be used in commerce games, as it has no effect otherwise. \n\nTo use it, select Gift Gold from the game's menu, how much gold to give, and which player you wish to give it to. The gold will be given immediately, and can be spent by the receiving player right away. \n\nOne use of this mod is for team games where you wish to share gold amongst your teammates.";
	mods["Gift Gold"]["How to use"] = "This mod is menu-based, meaning that players must use the mod via the menu provided by the mod author. When you open the menu you’ll see a window pop up. This window has 3 different inputs you’ll have to use / specify before the mod can give gold to someone. The first one being the [Select player…] button. When you tap / click this button another window will pop up and the mod prompts you to choose a player out of a list of all players excluding yourself. Choose the player you want to give the gold to and the window will close, returning to the first window that was kept open. Instead of “select player…” it will now say the player you’ve chosen. \n\nThe next input we have to specify is the amount of gold we would like to give away to the player. You can alter the amount of gold by using the slider or number input field. Once you have specified the amount of gold there is only 1 input left for us to use.At last, we tap / click on the [Gift] button. We get a pop up that the gold has been sent, and it tells us how much gold we have left. The receiver receives his gold immediately and your gold gets modified too.";
	mods["Gift Gold"]["how to set up"] = "This mod requires the game to be a commerce game. Armies are a different thing than gold and the mod only is able to give gold away to players. As host, you must therefore set the game to commerce manually since the mod doesn’t overwrite this setting. ";
	mods["Gift Gold"]["Bugs"] = "When gifting gold at T0 the value in the top left doesn’t get updated. When you did give gold away and did your turn normally (spending too much gold) the game will not accept your turn until you’ve adjusted your gold spend.";
	mods["Gift Gold"]["Compatibility"] = compatibilityAllMessage;
	mods["Picks Swap"] = {};
	mods["Picks Swap"]["Mod description"] = "Can't pick good? Great, this is for you. Pick the worst you can, as your opponent is playing with your picks. And you with his.";
	mods["Picks Swap"]["How does it work"] = "This mod completely swaps every territory you have after the distribution turn. You therefore should not pick good but pick really bad. \n\nIn a manual distribution game, you have to pick territories in an order of how badly you want them. Normally you would get the highest picked available territories of your pick list, but with this mod you’ll actually get those highest picked available territories of your opponent.";
	mods["Picks Swap"]["How to set up"] = "This mod only works with manual distribution, since the mod will have no effect on automatic distribution games.\n\nThis mod will also only work in a 2-player game. When the game has more players the mod will do nothing.";
	mods["Picks Swap"]["Bugs"] = bugFreeMessage;
	mods["Picks Swap"]["Compatibility"] = compatibilityAllMessage;
	mods["Randomized Bonuses"] = {};
	mods["Randomized Bonuses"]["Mod description"] = "Randomizes the value of each bonus by the given amount. For example, if you set the +/- limit to 2, each bonus will have its value changed by -2, -1, 0, +1, or +2 randomly when the game starts. ";
	mods["Randomized Bonuses"]["How does it work"] = "This mod changes bonus values with a random amount. Note that not all bonuses do get overridden all the time, more about this in how to set up.\n\nThe mod takes a look at every bonus and takes its value. It then asks for a random number between -x and x (where x is the number the game creator configured) and adds it to the bonus value. That’s all really xD";
	mods["Randomized Bonuses"]["How to set up"] = "When you add the mod to the game you get the configuration menu for the mod. Here you can configure how big the random number can be (both for negative and positive). If you set it to 3, bonus values can be modified with a random number out of the range -3 and 3 (-3, -2, -1, 0, 1, 2, 3).\n\nIt also has the option to allow negative bonuses. If you leave this option off there will be no overridden bonuses that are negative. But it does more than that. It will also not change a bonus value if its default value is 0 or lower. Enabling negative bonuses will allow the mod to change every bonus with a random number.\n\nNote that the mod will always take the default bonus value. The mod will not take any manually or already overwritten bonuses into account. Also the overridden bonuses are capped at -1000 and 1000.";
	mods["Randomized Bonuses"]["Bugs"] = bugFreeMessage;
	mods["Randomized Bonuses"]["Compatibility"] = "This mod is compatible with every other mod and setting, except for already overridden bonuses. It will always take its default value.";
	mods["Randomized Wastelands"] = {};
	mods["Randomized Wastelands"]["Mod description"] = "Randomizes the size of each wasteland by the given amount. For example, if you set the +/- limit to 2, each wasteland will have its size changed by -2, -1, 0, +1, or +2 randomly when the game starts.";
	mods["Randomized Wastelands"]["How does it work"] = "Wastelands normally have a static amount of armies, which is configured by the game creator. This mod takes a random number and adds this together with the wasteland armies. More specifically, if you configure it right (or wrong) it will modify all neutral armies with a random number of armies.\n\nThe mod looks at every territory to check how many armies it has. If the amount of armies is the same as the wasteland size and the territory is neutral it knows the territory is a wasteland. It then asks for a random number between -x and x (where x is configured by the game creator) and adds this to the wasteland. \n\nWarzone mods do not have a reliable way to check if a territory is a wasteland. You can therefore do some fancy stuff with this mod. More about this in advanced usage.";
	mods["Randomized Wastelands"]["How to set up"] = "The mod configuration consists of a single number input field and slider. This number will represent both the maximum increment and the maximum decrement. \n\nFor a normal usage of this mod you should enable wastelands for your game, otherwise the mod would likely do nothing. But there is a unique way to use this mod in another way. More about this in advanced usage";
	mods["Randomized Wastelands"]["Advanced usage"] = "As mentioned before the mod checks every territory to see if the territory is neutral and if the amount of armies is the same as the wasteland size. You can kinda abuse this when you set the wasteland size the same as normal neutrals (this accounts for both neutral in and outside the distribution). Let’s say that neutral that were in the distribution but a player did not end up with is set to 5 armies and the wasteland size is also set to 5 armies. When the game is created the mod will both take wastelands AND neutrals that were in the distribution but a player did not end up with to modify the amount of armies. You can use this to create games with completely randomized neutrals. \n\nThis also allows you to modify neutrals even if wastelands are not enabled. When wastelands are not enabled, the default wasteland size is 100. However, if you enable wastelands and set the wasteland size to another value and disable it again, it will remember the value you last stored. The mod does not check if wastelands are enabled but will always change any neutral territories that have the same number of armies as the wasteland size. So with this mod included and wastelands excluded, any neutral territory with 0 number of armies will get modified.";
	mods["Randomized Wastelands"]["Bugs"] = bugFreeMessage;
	mods["Randomized Wastelands"]["Compatibility"] = compatibilityAllMessage;
	mods["Advanced Diplo Mod V4"] = {};
	mods["Advanced Diplo Mod V4"]["Mod description"] = "Don't use this mod with any other mod with a notifications system, else it may happen that the notifications don't show up. \n\nThis Mod adds: War/Peace System: \n - Attacks DON'T count as declaration \n - After you declared War on someone, you have to wait one turn before you can attack him \n - Sanction, Bomb, Gift, Spy Card can be configurated, that they are just playable if you are in war/peace/ally with the persons you play them on\n - you start at peace with everyone \n\nAlliance System: can be disabled over settings\n - You will be able to see the territories your ally owners (requires spycards to be in the game)(depends on settings)\n - Alliances can be either public or private(depends on the settings)\n - After you cancel an alliance you gotta wait till the next turn to declare war\n\nAIs for Diplos:\n - AIs won't declare war on players(depends on settings)\n - AIs won't declare war on AIs(depends on settings)\n - AIs will always accept peace so if you do not want to be in war anylonger with a booted player you can just offer the AI peace and it will automatically accept it\n\nMod internal history between turns:\n - All mod interaction is documented between turns in the mod history and gets written into the normal history\n - It is separated in: \n --- public (Accepting peace and depending on settings accepting alliances), it can be seen by anyone \n --- private (sending offers and denying offers and depending on settings accepting alliances), it can only be seen by involved players";
	mods["Advanced Diplo Mod V4"]["How to use"] = {};
	mods["Advanced Diplo Mod V4"]["How to use"]["Essentials"] = "This is a quite big, relatively frequently used mod. I've played with this mod a lot and it is a reliable way to have some sort of forced diplomacy in a game. Before we go in deeper how to use this mod, there are some key details you need to know.\n\nFirst off, the mod keeps track of your \"relation state\" with other players. There are 3 states you can be in, those are\n - War\n - Peace\n - Alliance \n\nWhen a game starts you'll always be at peace with everyone, there is no way you can attack other players in the first turn.\n\nSecond, some cards can be configured if you can play the cards on players in a specific relation state. Those cards are\n - Bomb card\n - Sanction card\n - Spy card\n - Gift card\n\nThe game creator can configure all these cards differently, so make sure you read the mod settings. Every card configuration is listed perfectly as should be.\n\nThis mod is a menu based mod. All the features and options are in the custom mod menu.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Declaring war"] = "When a game starts, everyone is at peace with each other. This means that any attacks on players in the first turn will get skipped. The only territories you can conquer are that of neutral territories. Players can decide they want to change this and can declare war on a player whenever they like. When you open the mod menu you’ll see some buttons (note that some of the buttons might be interactable and some not, this can change from time to time). Let’s say we want to declare on AI 1. We click the [Declare War] button and end up in the next window. Here we can choose a player if we click / tap the [Select player…] option (note that only the players you’re at peace with will be listed). This will prompt us to choose a player or to cancel the action. After we have chosen the player the value on the  [Declare War] button has been changed to the player name we chose, in this example to AI 1. Now we click on the Declare button and the window will reset after adding an order in our orderlist with the following text: “Declare war on AI 1”. Now we can make the rest of our orders and submit the turn. The player you declared on has no choice in either fight or send you a peace request.\n\nNote that when you submit your orders this “Declare war” order will always be executed as one of the last orders of the turn. This means that you always have to wait to attack the player till the next turn.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Offering peace"] = "When you’re done with a war you can send the other player a peace request. Just follow the exact same path as is listed at declaring war. The main thing that is different compared to declaring war is instead of the players you’re in peace with, only the players you’re in war with will be listed. \n\nWhen you click the button [Offer] your client will send the server a message with the information the mod needs. The server will update the client of the player you send a peace request about the open peace offer. When the player accepts the peace the server will update your client again about it. Note that only when the other player has accepted the peace offer there will be peace, as long as the peace offer is pending the war will still remain.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Offer an alliance"] = "When you want to have an alliance with another player you can send him an alliance request. To do this you can follow the steps listed at declaring war. Note that only players you are at peace with will appear in the list.\n\nWhen you click the button [Offer] your client will send the server a message, same as with a peace offer. The only difference between offering peace and offering an alliance is that when you (either you or the player you’ve sent it to) have a pending alliance offer you can’t attack the other player, while with a pending peace offer you and the other player are still able to attack each other.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Cancelling an alliance"] = "When you have an alliance you can cancel this by following the same steps as listed at declaring war. The alliance cancel will have the same order behavior, it will appear in your order list and always will be one of the last orders. Note that you can’t declare war on a player in the same turn you canceled the alliance between you two. This means that there you will be able to attack a former ally after 2 turns. 1 turn is spent canceling the alliance, the next turn is spent declaring war on that player and thus the third turn is the first turn you two can attack each other.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Mod History"] = "Another feature of this mod is that it keeps track of its history because the alert system doesn’t work that well sometimes. When you click / tap the button [Mod history] you’ll be able to see what will be written to the turn history before everyone has submitted their turn.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Some last notes"] = "AI’s will always accept peace offers. If you are in war with an AI or the player turned AI you can guarantee peace by sending a peace offer to the player / AI. The mod will immediately tell you the peace offer has been accepted.";
	mods["Advanced Diplo Mod V4"]["How to use"]["Player list"] = "I’ll have to admit it, I just found out about this feature while writing this manual xD. If you are on the main menu and scroll down you’ll find a list of your current diplomacy. It will list out every player in their category, depending on your “relation state”.";
	mods["Advanced Diplo Mod V4"]["How to set up"] = {};
	mods["Advanced Diplo Mod V4"]["How to set up"]["AI settings"] = "There are 2 settings you can turn on or off. The “Allow AIs to declare on Player” option makes the AI declare on a player when it borders him. This is sometimes annoying since you’ll have to send the AI a peace request every turn if you don’t want to be in war with the AI. The other option allows AIs to declare on other AIs. Note that most of these wars are ended by elimination since AIs don’t send peace offers. The only way these wars end is by one of the players returning from the game after a boot / surrender and sending a peace request."
	mods["Advanced Diplo Mod V4"]["How to set up"]["Alliance settings"] = "With the first option you can remove the alliance system from the mod. Players will not be able to send and accept alliance requests if this option is enabled.\n\nWith the other 2 options the spy card has to be enabled to do something, since the mod will automatically play a spy card on everyone you’re allied with (or even on those players that are allied to your allies)";
	mods["Advanced Diplo Mod V4"]["How to set up"]["Card Settings"] = "4 cards can be configured to be played on players where you have a certain “relation state” with. These cards are the sanctions card, bomb card, spy card and gift card. Note if you disable all 3 options of a card it can never be played on anyone, not even yourself.";
	mods["Advanced Diplo Mod V4"]["How to set up"]["Other Settings"] = "The last setting requires a spy card to be enabled in the game since it will allow you to see everyone you’re at peace with.";
	mods["Advanced Diplo Mod V4"]["Bugs"] = bugFreeMessage;
	mods["Advanced Diplo Mod V4"]["Compatibility"] = "Not compatible with other diplomacy mods:\n - Diplomacy\n - Diplomacy 2";
	-- AI's don't deploy
	-- Buy Cards
	-- Commerce Plus
	mods["Custom Card Package"] = {};
	mods["Custom Card Package"]["Bugs"] = "When a nuke is played the first attack / transfer gets skipped and added back when all the nukes have been played. This results in the fact that the player who has first move will have 2 attacks / transfers before any other attacks / transfers have been played."
	-- Diplomacy 2
	-- Late Airlifts
	-- Limited Attacks
	mods["Limited Multiattacks"] = {};
	mods["Limited Multiattacks"]["Mod description"] = "This mod allows you to limit the attack range of multiattack. Furthermore, you can bind it to cards";
	mods["Limited Multiattacks"]["How to use"] = "It is quite important to check up on the mod settings when a game uses this mod. There are 2 settings you have to know to use multi attack properly:\n - Is multi attack bound to a card or multiple cards?\n - What is the limit of a multi attack chain?\n\nWhen multi attack is bound to a card or multiple cards the effect of multi attack is only enabled when you’ve played one of those cards. If multi attack is bound to the reinforcement card you’ll only be able to use multi attack if you played the reinforcement card. If it is bound to multiple cards (say spy card and gift card) you’ll only have to play 1 of (either) those cards, not both to enable multi attack. Note that multi attack is only enabled for you if you played the card, if other players want to have multi attack they too have to play a card that enables it.\n\nIf you enable multi attack (or when it is always enabled) you still have to watch out for the limit of multi attacks. The mod keeps track of how many attacks armies have made so when they reach the limit the attacks are canceled, most of the time breaking your normal multi attack chain (an attack gets skipped, and all other attacks in the chain won’t go through since you don’t own the attacking territory) and leads to confusion for most players.\n\nWhen the limit of multi attacks is not set to 0 (0 is infinite multi attacks, currently not possible: see bugs) attacks after the limit reached will be canceled. If the limit is set to 5, you’re able to make 1 attack as you normally do in every warzone game and pre-route 4 other attacks using the same armies. If you make one more pre-routed attack it will get canceled, leading that (if there are even more) attacks after the canceled attack won’t happen as you would imagine since you don’t own the attacking territory at the time the order is happening.\n\nNote that when armies make a transfer they are completely stuck for the rest of the turn. This is the case in every Warzone game. it is not (yet) possible to cancel this, even in normal multi attack games.";
	mods["Limited Multiattacks"]["Smart expansion"] = "Because this mod can have a limit of multi attacks you sometimes can’t create 1 long attack chain to capture as many territories as you can. When you want to capture as many territories as possible you should create multiple little attack chains (with the maximum length equal to the limit of multi attacks allowed) with exactly enough armies to capture every territory on the way.";
	mods["Limited Multiattacks"]["How to set up"] = " - You don’t need to enable multi attack yourself, the mod will override this setting.\n - You can specify what the limit of multi attacks will be (see bugs for an ongoing issue). This value can be set to any number between 0 and 100.000.\n - To make the multi attacks behave like a normal Warzone game with multi attack you should keep the option on. If you keep the option off every failed attack will freeze the remaining armies on the territory the attack was from, canceling all attacks / transfers from this territory.\n - The remaining checkboxes are for binding multi attack to a card or cards. Check the boxes of the corresponding cards you want, if you want multi attack to be bound to a card or cards. If you don’t want multi attack to be bound to any card, leave all the checkboxes unchecked.";
	mods["Limited Multiattacks"]["Bugs"] = " - (Bug solved) When transferring to a territory all attack / transfer orders from the receiving territory gets canceled. Imagine some territories connected to each other. For simplicity we’ll use the alphabet as their names. You own territory A, the other territories (B, C and D) are neutral. Your first order is to attack B from A. Your second order is a pre-routed transfer from B back to A. Thereafter you (multi) attack territories C and D starting from A. The order list would look like this:\n - ? armies from A will attack/transfer B\n - ? armies from B will attack/transfer A\n - ? armies from A will attack/transfer C\n - ? armies from C will attack/transfer D\n\n The first 2 orders will execute without any interferrence as its supposed to, but since the second order is a transfer it would freeze all the armies at A, so the 3 order would get skipped. Because of this the 4th order would also be skipped since we don't control C\n\n - (bugfix in review) Currently it is not yet possible to set the limit of multi attack to 0, although the UI does tell you it is. Trying to do this results in an alert telling you it is not possible, and even if the value goes through it gets overwritten to 1. If you want to have unlimited multi attacks (most usable in combination with enabling it with cards) you can set it to 100.000, which is technically infinite multi attacks";
	mods["Limited Multiattacks"]["Compatibility"] = compatibilityAllMessage;
	-- Neutral Moves
	-- Safe Start
	-- Swap territories
	-- Take Turns
	mods["AI's don't play cards"] = {};
	mods["AI's don't play cards"]["Mod description"] = "Prevents AI's from playing cards, configurable for all (except reinforcement) cards AI's play. Note that checking a checkbox allows an AI to play that card";
	mods["AI's don't play cards"]["How to use"] = "This mod prevents AI from playing cards. It simply checks every order in the order list when a turn gets processed. When the mod finds a card being played by an AI, it checks if the AI is allowed to play the card (configurable in the mod configuration) and cancels the order if the AI is not allowed to play it. If a player gets booted but returns it will find (unless the AI decided to discard some cards) all his cards untouched.";
	mods["AI's don't play cards"]["How to set up"] = "When adding the mod to the game you’ll get the mod configuration. Here you’re able to specify for each AI playable card if AIs are allowed to play the card or not. Note that when adding the mod all the settings are on their default False value, when you want AIs to play a certain card (eg. the blockade card) you should tick the corresponding checkbox which will allow the AIs to play that card.\n\nThese 5 cards AIs play can be configured:\n - Blockade card\n - Emergency blockade card\n - Sanction card\n - Diplomacy card\n - Bomb card\n\nNote that AIs always play reinforcement cards, but canceling this is way more difficult due to the way warzone handles these cards (see Bugs below).";
	mods["AI's don't play cards"]["Bugs"] = "This isn’t really a bug, but it did make the mod behave differently than I expected. Since the effect of a reinforcement card goes into play immediately after playing it can not be canceled. Doing so will result in the effect going through and the AI keeping the card, meaning the AI would be able to play the card again next turn with the same thing happening.";
	mods["AI's don't play cards"]["Compatibility"] = compatibilityAllMessage;
	-- Better don't fail an attack
	-- Bonus Airlift
	-- BonusValue QuickOverrider
	-- Capture The Flag
	-- Connected Commanders
	mods["Decoy Card"] = {};
	mods["Decoy Card"]["Mod description"] = "Allows players to fake an army count on a territory\n\n[!] NOTE [!]\n\nThis mod is not compatible with some other mods and the army cap setting. Especially with Gift Armies you will allow players to generate infinite armies! To make sure you don't add incompatible mods include the mod Essentials, the mod will tell you with which settings and mods it is not compatible";
	mods["Decoy Card"]["How to use"] = "This mod adds a custom made card, accessible via the mod menu. When you have enough card pieces you can click / tap a territory you own to play the card. The best part of these decoy cards are that the player itself can determine how many armies they will show. The mod will keep track of the actual army count on the territory and when the time is there, it will convert the territory back to what it was.\n\nWhen the turn advances you will need to control the territory you played a decoy on, otherwise the card will not get played (just like the emergency blockade card). Pick your territory therefore wisely, the card will get lost.\n\nWhen you deploy on a territory in decoy, the initial deployment order will get skipped. But don’t worry, the armies will get added to actual army count stored by the mod. When a decoy card runs out, it will revert the army numbers to what is was before playing the card + the total number of armies deployed on the territory in decoy.\n\nObviously, you can use a decoy card to show you have way more armies than actually are on that territory. Some actions therefore are disabled for every territory in decoy. These actions are:\n - Attacking and transferring FROM a territory in decoy\n - Airlifting armies FROM a territory in decoy\nThese actions are disabled to make sure this mod is not exploitable, otherwise players could play a decoy card for millions of armies and use them. Not really the intention of this mod xD\n\nNote that although the decoy cards have a configurable duration (set by the game creator) it doesn’t mean they always last this full duration. Some actions that meet a specific condition will trigger the card to run out, like using a blockade card on the territory. The following actions will trigger a decoy card to run out:\n - Attacking a territory in decoy\n - Transferring TO a territory in decoy\n - Airlifting TO a territory in decoy\n - Gifting a territory in decoy\n - Blockading a territory in decoy (both normal and emergencies blockades)\nThe most special case (and the most fun to watch) is when a territory in decoy gets attacked. The mod will show the initial attack, but then reverts the order back. It will then let the decoy card expire, resetting the army count to the actual armies. Thereafter, the attack will get played again, but now everyone who can see the attacking and defending territory will see the actual results of the attack.\n\nAll other cases above will expire the decoy card too. This is to prevent armies from being lost (transferring TO or airlifting TO a territory in decoy) or to prevent the mod from being exploited";
	mods["Decoy Card"]["How to set up"] = "Note that this mod is quite incompatible with other mods, mostly because the effects can be enormous. More about this in the compatibility section.\n\nJust like most cards, the decoy card can be configured in duration, number of pieces a player needs for a whole card and how many starting pieces each player starts with. The only option that is not configurable is the amount of pieces a player gets each turn, this is defaulted to 1.";
	mods["Decoy Card"]["Bugs"] = bugFreeMessage;
	mods["Decoy Card"]["Compatibility"] = "Like I mentioned above, this mod is quite incompatible with other mods mostly because the effects can be enormous. Here below is a list of incompatible settings and mods:\n - Commanders (and other special units)\nSpecial units can be lost when a decoy card is played, and so far no one has found a perfect workaround for this.\n\n - Gift armies (1 and 2)!\nThis mod allows players to gift armies from a specific territory to other players, but these 2 mods make an enormous exploit where players can gift each other billions of armies. I highly recommend never use these mods in combination\n\n - Custom Card Package\nNote that only part of this mod is not compatible with the decoy card mod. Using the decoy card mod in a game with Pestilence cards can be incompatible, because a territory in decoy can turn neutral. This messes up the decoys, but might not occur. Nevertheless, I recommend not using these 2 cards together";
	-- Deployment Limit
	-- Don't lose a territory
	-- Extended Randomized bonuses
	-- Extended Winning Conditions
	mods["Forts"] = {};
	mods["Forts"]["Mod description"] = "This mod allows players to build a fort. Any armies on a territory with a fort cannot be harmed by an incoming attack, but any incoming attack will destroy the fort. Therefore, as an attacker, it's a good idea to attack a fort with 1 army to destroy it with minimal losses. \n\nForts are represented on the map as an Army Camp icon. This mod assumes any Army Camp icons on the map are a fort, and therefore it is not compatible with any other mods that use the Army Camp icon.";
	mods["Forts"]["How does it work"] = "Any territory with an army camp structure (the same image as the one in Idle) will successfully defend an attack without losing any armies. This will destroy the fort (represented by an army camp) though. So any follow up attacks that follow will kill defending armies like normal unless the territory in question has another (or more) forts.\n\nForts can be built using the mod menu. Here you can select which territory you want to place the fort on and commit the order. Note that these orders always are played at the very end of the turn.\n\nPlayers can build forts themselves after every X amount of turns. X is here a fixed number between 1 and infinity. If X is equal to 3 you’re able to build a fort while creating your orders for turn 4 and you’re able to build a second fort while creating your orders for turn 7. \n\nIf the explanation above is not clear enough, try to see the forts placement process as a new card. Every player starts with 0 pieces, always gets 1 piece a turn and needs X amount of pieces to get a full card. When you have enough pieces you’re able to play the card and so place a fort.";
	mods["Forts"]["How to set up"] = "This mod does not need any extra settings and only has 1 setting itself. In the mod configuration you can configure after how many turns a player can build a fort.";
	mods["Forts"]["Bugs"] = bugFreeMessage;
	mods["Forts"]["Compatibility"] = "This mod is compatible with every mod and setting in Warzone, although it might cause strange behavior when paired with a mod that also uses army camps for something.";
	-- Gift Armies 2
	mods["Highest Income Disadvantage"] = {};
	mods["Highest Income Disadvantage"]["Mod description"] = "Every player with the highest income will become visible for all the other players";
	mods["Highest Income Disadvantage"]["How does it work"] = "This mod is fairly simple, if you have the highest income at the end of the turn your opponents will all be able to see you.\n\nThe duration of how long they can see you is bound to the spy card itself.\n\nIf multiple players have the same, highest income they all will be made visible for every player";
	mods["Highest Income Disadvantage"]["How to use"] = "Just adding the mod to the game will make it work. If the game does not use a spy card the mod will add it, making it not acquirable for players (0 weight, 0 pieces a turn, 0 starting pieces)";
	mods["Highest Income Disadvantage"]["Bugs"] = bugFreeMessage;
	mods["Highest Income Disadvantage"]["Compatibility"] = compatibilityAllMessage;
	mods["Hybrid Distribution"] = {};
	mods["Hybrid Distribution"]["Mod description"] = "Allows for some territories to be auto-distributed and some to be manual-distributed (picked).";
	mods["Hybrid Distribution"]["How to use"] = "Normally you would have either an automatic distribution (get random territories) or a manual distribution where you could specify an order of picks to allow you to set yourself up. This mod combines the two, resulting in a ‘hybrid’ distribution.\n\nThe game creator can specify how many territories everyone gets before the distribution phase. You will have at least one territory on the map and everyone can see this. You can also see everyone else their auto-distributed territories so you can use this information in the distribution phase.";
	mods["Hybrid Distribution"]["How to set up"] = "This mod only has one setting, the number of auto-distributed territories. There are a few notes though.\n - You have to set the game to manual distribution yourself, the mod doesn’t overwrite this setting and the mod will do nothing if the game uses automatic distribution\n - The mod will auto distribute territories from neutrals, leaving the pickable territories. Note that playing with full distribution and no wastelands the mod will not auto-distribute territories and note that when playing with full distribution and wastelands enabled the mod will only auto-distribute wastelands.\n - The mod will not overwrite the number of armies on the territories, so this would be equal to the number of armies in neutrals not in the distribution. Note that when playing with wastelands these army numbers don’t change. Players can end up with a wasteland, keeping the amount of armies.\n\nIf you’re looking to avoid one of these, you should use Hybrid Distribution 2";
	mods["Hybrid Distribution"]["Bugs"] = "Not really a bug, but a good feature to point out.\n\nThe mod does not overwrite the number of armies on the territory when auto-distributing. This will normally result in the auto-distributed territories having the same amount of armies the neutrals (not in the distribution) have, but when wastelands are enabled it can result in a player getting a wasteland. This can lead to unfair advantages / disadvantages. To play with wastelands and hybrid distribution I recommend using Hybrid Distribution 2 which does overwrite the number of armies.";
	mods["Hybrid Distribution"]["Compatibility"] = compatibilityAllMessage;	
	mods["Hybrid Distribution 2"] = {};
	mods["Hybrid Distribution 2"]["Mod description"] = "Allows for some territories to be auto-distributed and some to be manual-distributed (picked) with more options.\n - Choose if territories in the distribution or neutrals are auto-distributed\n - Choose if auto-distributed territories have the same amount of armies as manual-distributed territories or as neutrals not in the distribution\n - This mod overwrites wastelands, 'Hybrid Distribution' does not. This can lead to players having wastelands and thus more or less armies than their opponent\n - Forces the game to be manual distribution since the mod does nothing with auto distribution";
	mods["Hybrid Distribution 2"]["How to use"] = "The Hybrid Distribution 2 does the same thing as Hybrid Distribution but has more options and better compatibility.\n\nNormally you would have either an automatic distribution (get random territories) or a manual distribution where you could specify an order of picks to allow you to set yourself up. This mod combines the two, resulting in a ‘hybrid’ distribution.\n\nThe game creator can specify how many territories everyone gets before the distribution phase. You will have at least one territory on the map and everyone can see this. You can also see everyone else their auto-distributed territories so you can use this information in the distribution phase.";
	mods["Hybrid Distribution 2"]["How to set up"] = "The mod has 3 options, with one being similar to Hybrid Distribution. You’ll have to specify how many territories each player gets auto-distributed before the distribution phase. The other 2 options let you control which territories are auto-distributed and how many armies should be on those territories.\n\nThe second setting is a checkbox, which lets you control if the territories in the distribution are auto-distributed or neutrals (including wastelands, they get overwritten). The third option is also a checkbox and lets you specify what the amount of armies on the auto-distributed territories should be. Leaving this option checked will result in those territories having the same amount of armies as manual-distributed territories, unchecking this option will result in the same behavior as Hybrid Distribution except for the fact this mod does override wastelands.";
	mods["Hybrid Distribution 2"]["Bugs"] = bugFreeMessage;
	mods["Hybrid Distribution 2"]["Compatibility"] = compatibilityAllMessage;
	-- Information for spectators
	mods["King of the Hills"] = {};
	mods["King of the Hills"]["Mod description"] = "This mod adds one new rule: If you hold all hills at the end of a turn, you win. The number and size of hills can be altered. The hills are indicated with Mines and can be found by clicking 'Game' on the bottom left and then 'Mod: King Of The Hill'. In team games, the game ends when a team holds all the hills.";
	mods["King of the Hills"]["How does it work"] = "This mod adds a new feature to the game, an extra method / strategy to win a game. The mod chooses a few random territories on the map which will work like ‘hills’ (the number of territories is configurable) which are indicated by mines. These ‘hills’ don’t do anything except for when you control all the hills in the game at the end of a turn. Your opponents will automatically lose all their territories and thus are eliminated, leaving only you in the game which makes you the winner. This even works with teams, if a team holds all the ‘hills’ at the end of a turn all the other teams will get eliminated. In this case it doesn’t matter if one player holds all the ‘hills’ or multiple do.";
	mods["King of the Hills"]["How to set up"] = "There are 2 configurable options. The number of hills and the number of armies the hills will have at the start of the game. \n\nDue to how the mod configuration is set up, I wouldn’t recommend setting up a game with it on mobile since the text is barely readable.";
	mods["King of the Hills"]["Bugs"] = bugFreeMessage;
	mods["King of the Hills"]["Compatibility"] = "It is compatible with every mod, but do keep out other mods that adds mines to the game since this can be confusing for the players.";
	mods["Local Deployment Helper"] = {};
	mods["Local Deployment Helper"]["Mod description"] = "Credits to TBest who came up with this solution! \n - Takes your order from the previous turn and adds them to your order list\n - Automatic local deployment bonus overwriter\n - Recommended to play with 'can attack with percentage'!";
	mods["Local Deployment Helper"]["How to use"] = "This mod adds 2 features to Warzone, both related to local deployment. The first and main feature is the order helper, which takes orders from the previous turn and adds this back into the players' order list. The other function helps game creators to create local deployment games by automatically overwriting the necessary bonuses.\n\nThe order helper allows players to re-add most of their orders from the previous turn back into their current order list. This is really helpful in local deployment, because most of the orders are just the same from the previous turn (deployments behind frontlines and transfers behind the front line). When you use the order helper, you can specify which orders you want to add back. This is also really helpful because you can add orders in stages. The way I prefer to make my turns is to add all the deployments from the previous turn and make changes to them if necessary. I then make attack / transfer orders that I want to occur as the first few orders, and re-add all the transfers from the previous turn via the mod.";
	mods["Local Deployment Helper"]["How to set up"] = "The automatic bonus overwriter is handy but not perfect. It will ignore any manual overwritten bonuses for some reason. It will also leave every bonus as it is, not changing the value of it. You therefore have only bonuses equal to their normal (default) bonus value and those bonuses which require to be 0 to play local deployment on the map. But there is a workaround for this. You can create a game in singleplayer and let the bonus overwriter make the map local deployment ready. In the game, if you go back to settings it will actually show which bonuses have been overridden so you can make a template of it. When you create a multiplayer game you can then turn off the automatic bonus overwriter and alter those bonuses not equal to 0 to whichever value you want.\n\nTo use the order helper the best I recommend using percentage attacks / transfers. When orders are not percentage attacks / transfers it can occur that some orders do not move all troops on a territory.";
	mods["Local Deployment Helper"]["Bugs"] = bugFreeMessage;
	mods["Local Deployment Helper"]["Compatibility"] = "This mod is compatible with every other mod, except for Randomized Bonuses and BonusValue QuickOverrider if the automatic bonus overrider is being used. On a map with superbonuses it may occur that the automatic bonus overrider overrides a bonus that gets later overwritten again by one of these mods. This can be avoided by creating a singleplayer game with either of these mods, copy the template into multiplayer, remove the bonus overrider mod and add the Local Deployment Helper mod.";
	-- Lotto Mod -> Instant Random Winner
	-- More_Distributions
	-- One Way Connections
	mods["Press This Button"] = {};
	mods["Press This Button"]["Mod description"] = "This mod adds a button that will reduce the next turn's income of a player by X% if they do not press the button in their current turn. AI's will not be affected by this mod. Once the game started, you can find the button under Game > Press This Button";
	mods["Press This Button"]["How to use"] = "This mod adds something like a dead man’s button to the game, with a punishment if the player does not push the button in time for the next turn. If you succeed in pushing the button, nothing will happen. If you fail to push the button, then your income will get adjusted downwards by a certain percentage. The button can be found in the mod menu. It's big, red and hard to miss :)";
	mods["Press This Button"]["How to set up"] = "There are 2 configurable options. The first option is the percentage of income the player will lose when the player fails to hit the button in time. This number can be anywhere between 1 and 100 percent.\n\nThe second option is to allow the mod to warn the player when they have failed to push the button the previous turn. Unchecking this checkbox won’t send out an alert to the player when they fail to push the button.";
	mods["Press This Button"]["Bugs"] = bugFreeMessage;
	mods["Press This Button"]["Compatibility"] = compatibilityAllMessage;
	-- Random Starting Cities
	-- Reversed Bonus Armies Per Territory
	-- Runtime Wastelands
	-- Spawnbarriers
	mods["Special units are Medics"] = {};
	mods["Special units are Medics"]["Mod description"] = "This Mod allows special units to revive 100% of the lost armies in the territories connected to the special units. The effect won't work if they are killed by a bomb card or if a special unit is involved in any way in the attack (including if the attack comes from a territoy with a special unit.)";
	mods["Special units are Medics"]["How to use"] = "This mod is relatively simple and allows you to do some crazy stuff, things like generating armies while you’re expanding or defend twice with armies while defending. But when you want to use these methods you do need to know when your armies get revived. There are 2 scenarios where the mod will revive your lost armies back:\n - You defend against a player / AI while both defending and attacking territory don’t contain a special unit\n - You attack anyone (neutral, AI, a player) and (one of) your special unit(s) is next to the defending territory, but not on the attacking territory.\n\nIf these scenarios above are a bit difficult to understand, just know that whenever a special unit is involved in the attack your armies won’t get revived. Note that so far of all the special units only the commander is available for use, the four bosses can be made available for Warzone multiplayer and custom single player games but there is yet a mod to be made for it. ";
	mods["Special units are Medics"]["How to set up"] = "There are no options on this mod, but to make the mod actually do something you’ll need to include special units in your game. So far the only special unit is the commander, the four bosses are available for mods but are not yet included in any.";
	mods["Special units are Medics"]["Bugs"] = bugFreeMessage;
	mods["Special units are Medics"]["Compatibility"] = compatibilityAllMessage;
	-- Stack Limit
	-- Transport Only Airlift
end

function initSeeAlsoList()
	seeAlsoList = {};
	seeAlsoList["Buy Neutral"] = {};
	table.insert(seeAlsoList["Buy Neutral"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Buy Neutral"], "Essentials/Mod configuration");
	seeAlsoList["Diplomacy"] = {};
	table.insert(seeAlsoList["Diplomacy"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Diplomacy"], "Diplomacy 2");
	table.insert(seeAlsoList["Diplomacy"], "Advanced Diplo Mod V4");
	seeAlsoList["Gift Armies"] = {};
	table.insert(seeAlsoList["Gift Armies"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Gift Armies"], "Gift Armies 2");
	table.insert(seeAlsoList["Gift Armies"], "Gift Gold");
	table.insert(seeAlsoList["Gift Armies"], "Decoy Card");
	seeAlsoList["Gift Gold"] = {};
	table.insert(seeAlsoList["Gift Gold"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Gift Gold"], "Gift Armies");
	table.insert(seeAlsoList["Gift Gold"], "Gift Armies 2");
	seeAlsoList["Randomized Bonuses"] = {};
	table.insert(seeAlsoList["Randomized Bonuses"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Randomized Bonuses"], "Extended Randomized Bonuses");
	seeAlsoList["Randomized Wastelands"] = {};
	table.insert(seeAlsoList["Randomized Wastelands"], "Essentials/Mod configuration");
	seeAlsoList["Advanced Diplo Mod V4"] = {};
	table.insert(seeAlsoList["Advanced Diplo Mod V4"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Advanced Diplo Mod V4"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Advanced Diplo Mod V4"], "Diplomacy");
	table.insert(seeAlsoList["Advanced Diplo Mod V4"], "Diplomacy 2");
	seeAlsoList["Limited Multiattacks"] = {};
	table.insert(seeAlsoList["Limited Multiattacks"], "Essentials/Mod settings");
	table.insert(seeAlsoList["Limited Multiattacks"], "Essentials/Mod configuration");
	seeAlsoList["AI's don't play cards"] = {};
	table.insert(seeAlsoList["AI's don't play cards"], "Essentials/Mod configuration");
	seeAlsoList["Decoy Card"] = {};
	table.insert(seeAlsoList["Decoy Card"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Decoy Card"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Decoy Card"], "Gift Armies");
	table.insert(seeAlsoList["Decoy Card"], "Gift Armies 2");
	table.insert(seeAlsoList["Decoy Card"], "Custom Card Package");
	seeAlsoList["Forts"] = {};
	table.insert(seeAlsoList["Forts"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Forts"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Forts"], "Capture The Flag");
	seeAlsoList["Hybrid Distribution"] = {};
	table.insert(seeAlsoList["Hybrid Distribution"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Hybrid Distribution"], "Hybrid Distribution 2");
	seeAlsoList["Hybrid Distribution 2"] = {};
	table.insert(seeAlsoList["Hybrid Distribution 2"], "Essentials/Mod configuration");
	table.insert(seeAlsoList["Hybrid Distribution 2"], "Hybrid Distribution");
	seeAlsoList["King of the Hills"] = {};
	table.insert(seeAlsoList["King of the Hills"], "Essentials/Mod menu");
	table.insert(seeAlsoList["King of the Hills"], "Essentials/Mod configuration");
	seeAlsoList["local Deployment Helper"] = {};
	table.insert(seeAlsoList["local Deployment Helper"], "Essentials/Mod menu");
	table.insert(seeAlsoList["local Deployment Helper"], "Essentials/Mod configuration");
	seeAlsoList["Press This Button"] = {};
	table.insert(seeAlsoList["Press This Button"], "Essentials/Mod menu");
	table.insert(seeAlsoList["Press This Button"], "Essentials/Mod configuration");
	seeAlsoList["Special Units are Medics"] = {};
	table.insert(seeAlsoList["Special Units are Medics"], "Hospitals");
end

function initCompatibility()
	comp = {};
	comp["Connected Commanders"] = {};
	comp["Decoy Card"] = {};
	comp["Neutral Moves"] = {};
	comp["Connected Commanders"]["Late Airlifts"] = {};
	comp["Connected Commanders"]["Late Airlifts"].Occurance = "rare";
	comp["Connected Commanders"]["Late Airlifts"].Message = "There are a lot of requirements for the mod interference to occur, but when they it occurs the event player will not like it...\n\nPlease read more about this mod interference under [compatibility] to be sure you want both these mods into the game";
	comp["Decoy Card"]["Gift Armies"] = {};
	comp["Decoy Card"]["Gift Armies"].Occurance = "common";
	comp["Decoy Card"]["Gift Armies"].Message = "These 2 mods in combination create an enormous exploit that players can abuse to gift millions of armies to eachother";
	comp["Decoy Card"]["Gift Armies 2"] = {};
	comp["Decoy Card"]["Gift Armies 2"].Occurance = "common";
	comp["Decoy Card"]["Gift Armies 2"].Message = "These 2 mods in combination create an enormous exploit that players can abuse to gift millions of armies to eachother";
	comp["Decoy Card"]["Custom Card Package"] = {};
	comp["Decoy Card"]["Custom Card Package"].Occurance = "uncommon";
	comp["Decoy Card"]["Custom Card Package"].Message = "Note: This mod interference only applies to the Pestilence card\nIt can occur that a territory in decoy turns neutral with the Pestilence card, meaning the player will lose the armies on that territory.";
	comp["Neutral Moves"]["Late Airlifts"] = {};
	comp["Neutral Moves"]["Late Airlifts"].Occurance = "common";
	comp["Neutral Moves"]["Late Airlifts"].Message = "Every airlift is made undone because of how Neutral Moves works. So essentially airlifts do transfer armies but the armies on every territory reset when Neutral Moves does it work"
end

function checkModInterference(mod1, mod2)
	if comp == nil then return false; end
	if comp[mod1] ~= nil then
		if mod2 == nil then return true; end
		if comp[mod1][mod2] ~= nil then
			return comp[mod1][mod2];
		end
	elseif comp[mod2] ~= nil then
		if mod1 == nil then return true; end
		if comp[mod2][mod1] ~= nil then
			return comp[mod2][mod1];
		end
	end
	return false;
end