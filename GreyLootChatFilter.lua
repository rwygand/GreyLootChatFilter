-- Settings
local frame = CreateFrame("FRAME")
local category = Settings.RegisterVerticalLayoutCategory("GreyLootChatFilter")

local function OnSettingChanged(setting, value)
	-- This callback will be invoked whenever a setting is modified.
	local variable = setting:GetVariable()
	--print("Setting changed:", variable, value)
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
	if addonName == "GreyLootChatFilter" then
		--print("Initializing SavedVariables for GreyLootChatFilter")
		if not GreyLootChatFilterDB then
			GreyLootChatFilterDB = {}
		end

		--for k,v in pairs(GreyLootChatFilterDB) do
        --		print(k.." = ".. (v and "true" or "false"))
		--end

	local name = "Filter Grey Loot? "
	local variable = "GreyLootChatFilter_filterGreyLoot"
	local variableKey = "filterGreyLoot"
	local defaultValue = true

	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, GreyLootChatFilterDB, type(defaultValue), name, defaultValue)
	setting:SetValueChangedCallback(OnSettingChanged)

	local tooltip = "When enabled, filters gray loot items from your chat log."
	Settings.CreateCheckbox(category, setting, tooltip)

	local name = "Filter Other's Crafting Messages? "
	local variable = "GreyLootChatFilter_filterCraftingChat"
	local variableKey = "filterCraftingChat"

	local setting = Settings.RegisterAddOnSetting(category, variable, variableKey, GreyLootChatFilterDB, type(defaultValue), name, defaultValue)
	setting:SetValueChangedCallback(OnSettingChanged)

	local tooltip = "When enabled, filters other people's crafting messages."
	Settings.CreateCheckbox(category, setting, tooltip)

	end
end)

Settings.RegisterAddOnCategory(category)

-- end Settings

local filterFunc = function(self, event, msg, author, ...)
    if GreyLootChatFilterDB.filterGreyLoot then
        local itemInfo = string.match(msg, "%[(.-)%]")
        local _, _, quality = C_Item.GetItemInfo(itemInfo)

        if quality then
	        if quality == 0 then
		        return true
	        end
        end
    --else
	    --print("Didn't filter this item because config is false")
    end

    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filterFunc)

local craftingFilterFunc = function(self, event, msg, author, ...)
    if GreyLootChatFilterDB.filterCraftingChat and author ~= UnitName("player") then
        return true
    end
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_TRADESKILLS", craftingFilterFunc)

