local filterFunc = function(self, event, msg, author, ...)
    local itemInfo = string.match(msg, "%[(.-)%]")
    local itemName, _, quality = GetItemInfo(itemInfo)
    if quality == nil then
	    print("nil quality for " .. itemInfo)
	    return false;
    end
    if quality == 0 then
        return true;
    end
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filterFunc)
