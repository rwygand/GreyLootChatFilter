local filterFunc = function(self, event, msg, author, ...)
    local itemInfo = string.match(msg, "%[(.-)%]")
    local _, _, quality = C_Item.GetItemInfo(itemInfo)

    if quality then
	    if quality == 0 then
		    return true
	    end
    end

    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filterFunc)
