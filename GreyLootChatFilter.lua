local filterFunc = function(self, event, msg, author, ...)
    local itemName = string.match(msg, "%[(.-)%]")
    local item, _, quality = GetItemInfo(itemName)
    if quality == 0 then
        return true;
    end
    return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filterFunc)
