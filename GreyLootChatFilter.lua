-- Settings

local function OnSettingChanged(_, setting, value)
	local variable = setting:GetVariable()
	MyAddOn_SavedVars[variable] = value
end

local category = Settings.RegisterVerticalLayoutCategory("GretLootChatFilter")

do
    local variable = "filterGreyLoot"
    local name = "Filter Grey Loot"
    local tooltip = "If on, gray items will not appear in your chat log when looted."
    local defaultValue = true

    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
    Settings.CreateCheckbox(category, setting, tooltip)
	Settings.SetOnValueChangedCallback(variable, OnSettingChanged)
end

do
    local variable = "filterCraftingChat"
    local name = "Filter Crafting Chat"
    local tooltip = "If on, when chat logs from people crafting around you will be filtered."
    local defaultValue = true

    local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
    Settings.CreateCheckbox(category, setting, tooltip)
	Settings.SetOnValueChangedCallback(variable, OnSettingChanged)
end

Settings.RegisterAddOnCategory(category)

-- end Settings

local GreyLootChatFilter:filterFunc = function(self, event, msg, author, ...)
    if GreyLootChatFilterDB.filterGreyLoot then
        local itemInfo = string.match(msg, "%[(.-)%]")
        local _, _, quality = C_Item.GetItemInfo(itemInfo)

        if quality then
	        if quality == 0 then
		        return true
	        end
        end
    end

    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", GreyLootChatFilter:filterFunc)
