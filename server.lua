local skinsShops = {
    { 1469.28113, -1675.06982, 14.04688, 180 },
    { 1486.65625, -1674.46277, 14.04688, 180 },
};

for i, v in ipairs(skinsShops) do
    local skinsellerped = createPed(141, v[1], v[2], v[3], v[4])
    setElementData(skinsellerped, "ped:type", "skinshop")
    setElementFrozen(skinsellerped, true)
end

function buyskin(player, skinid, price)
    local playermoney = getPlayerMoney(player)
    if (playermoney > price) then 
        setPlayerMoney(player, playermoney-price)
        setElementModel(player, skinid)
    end 
end 
addEvent("buyskin", true)
addEventHandler("buyskin", root, buyskin)