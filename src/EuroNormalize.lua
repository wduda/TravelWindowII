if (tonumber("1,000") == 1) then
    function EuroNormalize(value)
        local retcode
        if value ~= nil then
            retcode = tonumber((string.gsub(value, "%.", ",")))
        end
        return retcode
    end
else
    function EuroNormalize(value)
        local retcode
        if value ~= nil then
            retcode = tonumber((string.gsub(value, ",", ".")))
        end
        return retcode
    end
end
