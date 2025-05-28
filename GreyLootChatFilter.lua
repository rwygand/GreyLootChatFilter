local filterFunc = function(self, event, msg, author, ...)
    local itemInfo = string.match(msg, "%[(.-)%]")
    local _, _, quality = GetItemInfo(itemInfo)
    return not (quality and quality > 0)
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filterFunc)
