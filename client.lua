local sx, sy = guiGetScreenSize()

local manskins = {1, 2, 7, 14, 15};
local womanskins = {9, 10, 11, 12, 13};

local currentSkin = 1
local type = ""
local price = 50

function pedclick (button, state, _, _, _, _, _, clickedElement)
    if (button == "right" and state == "up") then 
        if (clickedElement) then 
            if (getElementData(clickedElement, "ped:type") == "skinshop") then 
                local px, py, pz = getElementPosition(clickedElement)
                local x, y, z = getElementPosition(localPlayer)
                local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
                if (distance < 3) then 
                    addEventHandler("onClientRender", root, panelrender)
                    addEventHandler("onClientClick", root, click)
                    bindKey("backspace", "up", panelclose)
                    setElementFrozen(localPlayer, true)
                end
            end 
        end 
    end 
end 
addEventHandler("onClientClick", root, pedclick)

function panelrender()
    dxDrawRectangle(sx*0.4, sy*0.3, sx*0.2, sy*0.35, tocolor(50, 50, 50, 250))
    dxDrawText("SkinShop", sx*0.4, sy*0.31, sx*0.6, sy*0.35, tocolor(255, 255, 255, 255), 2, "default", "center")
    dxDrawRectangle(sx*0.4, sy*0.35, sx*0.2, sy*0.075, tocolor(66, 135, 245, isMouseInPosition(sx*0.4, sy*0.35, sx*0.2, sy*0.075) and 200 or 255))
    dxDrawText("Férfi skinek", sx*0.4, sy*0.37, sx*0.6, sy*0.075, tocolor(255, 255, 255, 255), 2, "default", "center")
    dxDrawRectangle(sx*0.4, sy*0.45, sx*0.2, sy*0.075, tocolor(245, 66, 66, isMouseInPosition(sx*0.4, sy*0.45, sx*0.2, sy*0.075) and 200 or 255))
    dxDrawText("Női skinek", sx*0.4, sy*0.47, sx*0.6, sy*0.075, tocolor(255, 255, 255, 255), 2, "default", "center")
    dxDrawRectangle(sx*0.4, sy*0.55, sx*0.2, sy*0.075, tocolor(66, 245, 90, isMouseInPosition(sx*0.4, sy*0.55, sx*0.2, sy*0.075) and 200 or 255))
    dxDrawText("Egyéb", sx*0.4, sy*0.57, sx*0.6, sy*0.075, tocolor(255, 255, 255, 255), 2, "default", "center")
end

function panelclose()
    removeEventHandler("onClientRender", root, panelrender)
    unbindKey("backspace", "up", panelclose)
    setCameraTarget(localPlayer)
    setElementFrozen(localPlayer, false)
    removeEventHandler("onClientRender", root, chosemanskin)
    removeEventHandler("onClientClick", root, click)
    unbindKey("arrow_l", "up", panelleft)
    unbindKey("arrow_r", "up", panelright)
    unbindKey("enter", "up", buyskin)
    currentSkin = 1
    type = ""
    if (selectorPed) then 
        destroyElement(selectorPed)
    end 
end 

function panelleft()
    if (currentSkin > 1) then 
        if (type == "man") then 
            currentSkin = currentSkin -1 
            setElementModel(selectorPed, manskins[currentSkin])
        elseif (type == "woman") then
            currentSkin = currentSkin -1 
            setElementModel(selectorPed, womanskins[currentSkin])
        end
    end 
end 

function panelright()
    if (type == "man") then 
        if (currentSkin < #manskins) then 
            currentSkin = currentSkin + 1 
            setElementModel(selectorPed, manskins[currentSkin])
        end 
    elseif (type == "woman") then
        if (currentSkin < #womanskins) then 
            currentSkin = currentSkin + 1 
            setElementModel(selectorPed, womanskins[currentSkin])
        end 
    end 
end 

function buyskin()
    if (getPlayerMoney(localPlayer) >= price) then 
        if (type == "man") then 
            triggerServerEvent("buyskin", localPlayer, localPlayer, manskins[currentSkin], price)
            exports["cc_infobox"]:addNotification("Sikeresen megvásároltad a ruházatot!")
        elseif (type == "woman") then 
            triggerServerEvent("buyskin", localPlayer, localPlayer, womanskins[currentSkin], price)
            exports["cc_infobox"]:addNotification("Sikeresen megvásároltad a ruházatot!")
        end 
        panelclose()
    else 
        exports["cc_infobox"]:addNotification("Nincs elég pénzed!")
    end 
end 

function click (button, state)
    if (button == "left" and state == "up") then 
        if (isMouseInPosition(sx*0.4, sy*0.35, sx*0.2, sy*0.075)) then -- Férfi skinek
            selectorPed = createPed(manskins[currentSkin], 1479.49866, -1671.04517, 14.55322, 180);
            removeEventHandler("onClientRender", root, panelrender)
            removeEventHandler("onClientClick", root, click)
            addEventHandler("onClientRender", root, chosemanskin)
            setCameraMatrix(1479.45410, -1674.82153, 15.04688, 1479.49866, -1671.04517, 14.55322)
            setElementFrozen(localPlayer, true)
            bindKey("arrow_l", "up", panelleft)
            bindKey("arrow_r", "up", panelright)
            bindKey("enter", "up", buyskin)
            type = "man"
        end 

        if (isMouseInPosition(sx*0.4, sy*0.45, sx*0.2, sy*0.075)) then -- Női skinek
            selectorPed = createPed(womanskins[currentSkin], 1479.49866, -1671.04517, 14.55322, 180);
            removeEventHandler("onClientRender", root, panelrender)
            removeEventHandler("onClientClick", root, click)
            addEventHandler("onClientRender", root, chosemanskin)
            setCameraMatrix(1479.45410, -1674.82153, 15.04688, 1479.49866, -1671.04517, 14.55322)
            setElementFrozen(localPlayer, true)
            bindKey("arrow_l", "up", panelleft)
            bindKey("arrow_r", "up", panelright)
            bindKey("enter", "up", buyskin)
            type = "woman"
        end 

        if (isMouseInPosition(sx*0.4, sy*0.55, sx*0.2, sy*0.075)) then -- Egyéb skinek
            outputChatBox("Hamarosan...")
        end 
    end 
end 

function chosemanskin()
    dxDrawRectangle(sx*0.4, sy*0.85, sx*0.2, sy*0.1, tocolor(50, 50, 50, 200))
    dxDrawText("Ár: "..price,sx*0.4, sy*0.88, sx*0.6, sy*0.1, tocolor(255, 255, 255, 255), 3, "default", "center")
    local _, _, pedz = getElementRotation(selectorPed);
    setElementRotation(selectorPed, 0, 0, pedz+1);
end 

function isMouseInPosition ( x2, y2, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x2 and cx <= x2 + width ) and ( cy >= y2 and cy <= y2 + height ) )
end