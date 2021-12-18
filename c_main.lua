local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local uiState = false
local licenses = {}

RegisterNUICallback("escapeUI", function()
    toggleUI()
end)

RegisterNUICallback("show", function(data)
    
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
    local thisPlayer = GetPlayerServerId(PlayerId())
    
    if closestPlayer == -1 or closestPlayerDistance > 3.0 then
        ESX.ShowNotification("~r~Es befindet sich kein Spieler in der Nähe!")
        toggleUI()
    else
        
        if data.licens == "id" then
            TriggerServerEvent('jsfour-idcard:open', thisPlayer, GetPlayerServerId(closestPlayer))
            ESX.ShowNotification("~g~showed ID")
        elseif data.licens == "dvm" then
            TriggerServerEvent('jsfour-idcard:open', thisPlayer, GetPlayerServerId(closestPlayer), 'driver')
            ESX.ShowNotification("~g~showed DMV")
        elseif data.licens == "gun" then
            TriggerServerEvent('jsfour-idcard:open', thisPlayer, GetPlayerServerId(closestPlayer), 'weapon')
            ESX.ShowNotification("~g~showed Gunlicense")
        end

    end


end)

RegisterNUICallback("err", function(data)
    ESX.ShowNotification(data.message)
end)

function toggleUI()

    if uiState then
        SendNUIMessage({action = "toggleUI", state = false})
        SetNuiFocus(false, false)
        uiState = false
    else

        ESX.TriggerServerCallback("wg_idCard:getLicens", function(licenses) 
            
            local car, gun = false, false

            for k, v in ipairs(licenses) do
                
                if v.type == "dmv" then
                    car = true
                elseif v.type == "weapon" then
                    gun = true
                end
            
            end
            
            SendNUIMessage({action = "toggleUI", state = true, licenses = {car, gun}})
            SetNuiFocus(true, true)
            uiState = true

        end)

    end

end

function openUI()

    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer == -1 or closestPlayerDistance > 3.0 then
        ESX.ShowNotification("~r~There are no Players near by!")
    else
        toggleUI()
    end

end

--Keymapping
RegisterCommand("openidmenu", function()
    openUI()
end, false)
RegisterKeyMapping("openidmenu", "License Menu", "keyboard", "I")