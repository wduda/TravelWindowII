function _G.AddCallback(object, event, callback)
    local handlers = object[event] or {}
    if type(handlers) == "function" then
        handlers = { [handlers] = handlers }
    end
    handlers[callback] = callback
    object[event] = handlers
end

function _G.RemoveCallback(object, event, callback)
    local handlers = object[event] or {}
    if handlers == callback then
        object[event] = nil
    else
        handlers[callback] = nil
        if next(handlers) == nil then
            -- Table is empty
            object[event] = nil
        end
    end
end
