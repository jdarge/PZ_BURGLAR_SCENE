BurglarScene = {}

BurglarScene.Add = function()

			addChallenge(BurglarScene);
	
end

BurglarScene.OnGameStart = function() 	
	
			Events.OnGameStart.Add(BurglarScene.freshStart);
			Events.OnGameStart.Add(BurglarScene.buildingAlarm);

end

BurglarScene.freshStart = function()
			
			local plyr = getPlayer();

			plyr:LevelPerk(Perks.Fitness);
			plyr:LevelPerk(Perks.Sprinting);
			plyr:LevelPerk(Perks.Strength);
			plyr:LevelPerk(Perks.Fitness);
			plyr:LevelPerk(Perks.Sprinting);
			plyr:LevelPerk(Perks.Strength);
			plyr:LevelPerk(Perks.Electricity);
			plyr:LevelPerk(Perks.Mechanics);
			plyr:LevelPerk(Perks.Mechanics);
			luautils.updatePerksXp(Perks.Fitness, plyr);
			luautils.updatePerksXp(Perks.Strength, plyr);
			luautils.updatePerksXp(Perks.Sprinting, plyr);
			luautils.updatePerksXp(Perks.Electricity, plyr);
			luautils.updatePerksXp(Perks.Mechanics, plyr);

			plyr:clearWornItems();
		    plyr:getInventory():clear();

			local inv = plyr:getInventory();
			local bag = plyr:getInventory():AddItem("Base.Bag_DuffelBag");

			BurglarScene.clothes = 
			{
			"Base.Shoes_BlueTrainers",
			"Base.Trousers_Black",
			"Base.Socks_Ankle",
			"Base.Gloves_LeatherGloves",
			"Base.HoodieDOWN_WhiteTINT",
			"Base.Hat_BalaclavaFull"
			}
			
			for i , item in pairs(BurglarScene.clothes) do
				clothes = inv:AddItem(item);
				plyr:setWornItem(clothes:getBodyLocation(), clothes);
			end

			--[[ 
			holster = inv:AddItem("Base.HolsterSimple");
			plyr:setWornItem(holster:getBodyLocation(), holster);
			wpn = inv:AddItem("Base.Pistol");
			wpn:setCurrentAmmoCount(14);
			wpn:setContainsClip(true);
			wpn:setRoundChambered(true);
			wpn:setAttachedSlot(4);
			plyr:setAttachedItem("Holster Right", wpn);
			wpn:setAttachedSlotType("HolsterRight");
			wpn:setAttachedToModel("Holster Right");
			--]]
			
			belt = inv:AddItem("Base.Belt2");
			plyr:setWornItem(belt:getBodyLocation(),belt);

			wpn = inv:AddItem("Base.Crowbar");
			wpn:setAttachedSlot(1);
			
			plyr:setPrimaryHandItem(wpn);
			plyr:setSecondaryHandItem(wpn);
			
			wpn = inv:AddItem("Base.Screwdriver")
			wpn:setAttachedSlot(2);
			plyr:setAttachedItem("Belt Left", wpn);
			wpn:setAttachedSlotType("BeltLeft");
			wpn:setAttachedToModel("Belt Left");

			BurglarScene.supplies = {"Base.CannedChili","Base.TunaTin"};
			BurglarScene.supplies2 = {"Base.Bandage","Base.AlcoholWipes"}
			
			inv:AddItem("Base.WaterBottleFull");
			inv:AddItem("Base.Lighter");
			inv:AddItem("Base.KeyRing");
			
			bag:getItemContainer():AddItem("Base.TinOpener");
			bag:getItemContainer():AddItem("Base.Cigarettes");
			
			-- bag:getItemContainer():AddItem("Base.WaterBottleFull");
			-- inv:AddItem("Base.9mmClip"):setCurrentAmmoCount(15);
			-- bag:getItemContainer():AddItem("Base.9mmClip"):setCurrentAmmoCount(15);
			
			for i , item in pairs(BurglarScene.supplies) do
				local giveit = 1;
				if giveit == 1 then
				local amt = 2;
				bag:getItemContainer():AddItems(item,amt);
				end
			end
			
			for i , item in pairs(BurglarScene.supplies2) do
				local giveit = 1;
				if giveit == 1 then
				local amt = 3;
				bag:getItemContainer():AddItems(item,amt);
				end
			end
			
			plyr:setClothingItem_Back(bag);
			
end


BurglarScene.OnInitWorld = function()

			Events.OnGameStart.Add(BurglarScene.OnGameStart);
			BurglarScene.setSandBoxVars();

end


BurglarScene.setSandBoxVars = function()

			local options= {}
	
			if getSandboxPresets():indexOf("BSChallenge")
				then
					options = getSandboxOptions();
					options:loadPresetFile("BSChallenge");
					options:toLua();
					options:updateFromLua();
					options:applySettings();
					SandboxVars.TimeSinceApo =  getSandboxOptions():getTimeSinceApo();
					SandboxVars.WaterShutModifier = 1;
					SandboxVars.ElecShutModifier = 1;
	
			else 
					SandboxVars = require "Sandbox/Apocalypse"

			end

			hourvalue = 7;
		
			gameTime = options:getOptionByName("StartTime"):getValue();
		
			if gameTime == 1 then return 
		
			elseif gameTime == 2 
				then hourvalue = 9;
		
			elseif gameTime == 3 
				then hourvalue = 12;
		
			elseif gameTime == 4 
				then hourvalue = 14;
		
			elseif gameTime == 5 
				then hourvalue = 17;
		
			elseif gameTime == 6 
				then hourvalue = 21;
		
			elseif gameTime == 7 
				then hourvalue = 0;
		
			elseif gameTime == 8 
				then hourvalue = 2;
		
			else hourvalue = 5 ;
		
			end 
		
			gt = getGameTime();
			gt:setTimeOfDay(hourvalue);
			gt:setDay(getSandboxOptions():getOptionByName("StartDay"):getValue());
			gt:setStartDay(getSandboxOptions():getOptionByName("StartDay"):getValue());
			gt:setMonth(getSandboxOptions():getOptionByName("StartMonth"):getValue()-1);

end

BurglarScene.buildingAlarm = function()

			local plr = getPlayer();
			local mData = plr:getModData();
			local mData.plrSpot = plr:getCurrentSquare():getRoom():getBuilding();

			if plr:getCurrentSquare():isOutside() == true
				or plr:getCurrentSquare():getRoom() == nil
				then return
			
			else
				mData.building = plr:getCurrentSquare():getRoom():getBuilding();
			
			end

			if mData.plrSpot == mData.building
				then mData.plrSpot:getDef():setAlarmed(true);
			end 

end	

BurglarScene.RemovePlayer = function(p)
end

BurglarScene.AddPlayer = function(p)
end

BurglarScene.Render = function()
end

BurglarScene.spawns = {

			{xcell = 24, ycell = 27, x = 54, y = 281, z = 0},
			{xcell = 35, ycell = 34, x = 136, y = 214, z = 0},
			{xcell = 20, ycell = 17, x = 81, y = 162, z = 0},
			{xcell = 39, ycell = 23, x = 204, y = 51, z = 0},
			{xcell = 26, ycell = 39, x = 273, y = 42, z = 0}
			
}

local spawnselection = ZombRand(5)+1;
local xcell = BurglarScene.spawns[spawnselection].xcell;
local ycell = BurglarScene.spawns[spawnselection].ycell;
local x = BurglarScene.spawns[spawnselection].x;
local y = BurglarScene.spawns[spawnselection].y;

BurglarScene.id = "BurglarScene";
BurglarScene.image = "media/lua/client/BS/BurglarScene.png";
BurglarScene.gameMode = "Burglar Scene";
BurglarScene.world = "Muldraugh, KY";

BurglarScene.xcell = xcell;
BurglarScene.ycell = ycell;
BurglarScene.x = x;
BurglarScene.y = y;
BurglarScene.z = 0;

BurglarScene.hourOfDay = 9;

Events.OnChallengeQuery.Add(BurglarScene.Add)
