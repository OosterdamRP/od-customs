----check tunes van de auto

local QBCore = exports['qbx-core']:GetCoreObject()

-- Functions
function GetVehicleName(vehicle)
    local hash = GetEntityModel(vehicle)
    for _,v in pairs(QBCore.Shared.Vehicles) do
        if v.hash == hash then
            return v.name
        end
    end
end

-- Performance tunes checken
RegisterNetEvent('od-customs:client:CheckTunes', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if not DoesEntityExist(vehicle) then return end

    local plate = QBCore.Functions.GetPlate(vehicle)
    local Engine = GetVehicleMod(vehicle, 11) + 1
    local Brakes = GetVehicleMod(vehicle, 12) + 1
    local Transmission = GetVehicleMod(vehicle, 13) + 1
    local Suspension = GetVehicleMod(vehicle, 15) + 1
    local Turbo = IsToggleModOn(vehicle, 18) and 1 or 0
    local Armor = GetVehicleMod(vehicle, 16) + 1
    local Performance = Engine + Brakes + Transmission + Suspension + Turbo + Armor

    lib.registerMenu({
        id = 'CheckTunes',
        title = GetVehicleName(vehicle) ..' [' .. tostring(plate) .. ']',
        position = 'top-right',
        options = {
            {label = 'Engine Level ' .. Engine .. '/4', description = 'Engine level max = 4, Stock = 0', icon = 'car-side'},
            {label = 'Brakes Level ' .. Brakes .. '/3', description = 'Brakes level max = 3, Stock = 0', icon = 'car-side'},
            {label = 'Transmission Level ' .. Transmission .. '/3', description = 'Transmission level max = 3, Stock = 0', icon = 'car-side'},
            {label = 'Suspension Level ' .. Suspension .. '/5', description = 'Suspension level max = 5, Stock = 0', icon = 'car-side'},
            {label = 'Turbo Level ' .. Turbo .. '/1', description = 'Turbo level max = 1, Stock = 0', icon = 'car-side'},
            {label = 'Armor Level ' .. Armor .. '/5', description = 'Armor level max = 5, Stock = 0', icon = 'car-side'},
        }
    })

    if GetVehicleDoorLockStatus(vehicle) == 2 then
        lib.notify({
            title = 'Auto gesloten',
            description = 'Vraag de eigenaar voor de auto te openen',
            type = 'warning',
            position = 'center-left'
        })
    elseif Performance < 1 then
        lib.notify({
            title = 'Geen modificaties',
            description = 'Deze auto heeft geen performance tunes',
            type = 'error',
            position = 'center-left'
        })
    else
        lib.progressCircle({
            duration = 3000,
            label = 'Checking tunes...',
            position = 'bottom',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {
                dict = 'anim@amb@business@cfm@cfm_cut_sheets@',
                clip = 'look_left_at_sheets_billcutter'
            },
        })
        lib.notify({
            title = 'Tune menu geopend',
            description = 'Deze auto heeft een aantal tunes',
            type = 'success',
            position = 'center-left'
        })
        lib.showMenu('CheckTunes')
    end
end)

local CarOptions = {
    {
        name = 'vehicle:checktunes',
        event = 'od-customs:client:CheckTunes',
        icon = 'fa-sharp fa-solid fa-car-side',
        label = 'Check Tunes',
        distance = 1.5,
    },
}

exports.ox_target:addGlobalVehicle(CarOptions)
