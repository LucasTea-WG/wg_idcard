local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

ESX.RegisterServerCallback("wg_idCard:getLicens", function(src, cb)
    TriggerEvent("esx_license:getLicenses", src, function(licenses) 
        cb(licenses)
    end)
end)