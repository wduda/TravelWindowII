-- get the actual value of the 1 based index of the bit
TravelWindowII.bit = function(p)
    return 2 ^ (p - 1);
end

-- Typical call:  if hasbit(x, bit(3)) then ...
TravelWindowII.hasbit = function(x, p)
    if (x % (p + p) >= p) then
        return true;
    else
        return false;
    end
end

TravelWindowII.setbit = function(x, p)
    return hasbit(x, p) and x or x + p;
end

TravelWindowII.clearbit = function(x, p)
    return hasbit(x, p) and x - p or x;
end

TravelWindowII.togglebit = function(x, p)
    if (hasbit(x, p)) then
        return clearbit(x, p);
    else
        return setbit(x, p);
    end
end



