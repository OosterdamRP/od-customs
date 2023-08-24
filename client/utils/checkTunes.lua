----check tunes van de auto

local QBCore = exports['qbx-core']:GetCoreObject()

-- Performance tunes checken
RegisterNetEvent('od-customs:client:CheckTunes', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    print('Found vehicle', vehicle)
    if not DoesEntityExist(vehicle) then return end

    local plate = QBCore.Functions.GetPlate(vehicle)
    print('Found plate', plate)
    local veh = QBCore.Functions.GetClosestVehicle()
    local vehicle = GetEntityModel(veh)
    print(vehicle)
    local Engine = GetVehicleMod(veh, 11) if Engine == -1 then Engine = 0 end
    print(Engine)
    local Brakes = GetVehicleMod(veh, 12) if Brakes == -1 then Brakes = 0 end
    print(Brakes)
    local Transmission = GetVehicleMod(veh, 13) if Transmission == -1 then Transmission = 0 end
    print(Transmission)
    local Suspension = GetVehicleMod(veh, 15) if Suspension == -1 then Suspension = 0 end
    print(Suspension)
    originalTurbo = IsToggleModOn(vehicle, 18)
    local Turbo = originalTurbo and 1 or 0
    print(Turbo)
    local Armor = GetVehicleMod(veh, 16) if Armor == -1 then Armor = 0 end
    print(Armor)
    local Performance = Engine + Brakes + Transmission + Suspension + Turbo + Armor
    print(Performance)
    lib.registerMenu({
        id = 'CheckTunes',
        title = 'Tunes',
        position = 'top-right',
        options = {
            {label = 'Engine Level ' .. Engine .. '/4', description = 'Engine level max = 4, Stock = 0', icon = 'car-side'},
            {label = 'Brakes Level ' .. Brakes .. '/3', description = 'Brakes level max = 3, Stock = 0', icon = 'car-side'},
            {label = 'Transmission Level ' .. Transmission .. '/4', description = 'Transmission level max = 4, Stock = 0', icon = 'car-side'},
            {label = 'Suspension Level ' .. Suspension .. '/5', description = 'Suspension level max = 5, Stock = 0', icon = 'car-side'},
            {label = 'Turbo Level ' .. Turbo .. '/1', description = 'Turbo level max = 1, Stock = 0', icon = 'car-side'},
            {label = 'Armor Level ' .. Armor .. '/5', description = 'Armor level max = 5, Stock = 0', icon = 'car-side'},
        }
    })

    if Performance < 1 then
        QBCore.Functions.Notify('Deze auto heeft geen performance tunes', 'error')
        print('No performance tunes')
    else
        QBCore.Functions.Notify('Deze auto heeft performance tunes', 'success')
        lib.showMenu('CheckTunes')
        print('Performance tunes present')
    end
end)

local CarOptions = {
    {
        name = 'vehicle:checktunes',
        event = 'od-customs:client:CheckTunes',
        icon = 'fa-sharp fa-solid fa-car-side',
        label = 'Check Tunes',
        distance = 2.0,
    },
}

exports.ox_target:addGlobalVehicle(CarOptions)
