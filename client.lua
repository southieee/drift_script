local driftModeEnabled = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlJustPressed(0, 21) then -- 21 is the control code for shift. Change it if needed
            TriggerEvent('ToggleDriftMode')
        end
    end
end)

RegisterNetEvent('ToggleDriftMode')
AddEventHandler('ToggleDriftMode', function()
    driftModeEnabled = not driftModeEnabled
    
    if driftModeEnabled then
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fInitialDragCoeff', 90.22)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fDriveInertia', 0.31)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fSteeringLock', 22)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fTractionCurveMax', -1.1)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fTractionCurveMin', -0.4)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fTractionCurveLateral', 2.5)
        SetVehicleHandlingFloat(GetVehiclePedIsUsing(PlayerPedId()), 'fLowSpeedTractionLossMult', -0.57)
        
        TriggerEvent('chat:addMessage', { args = { '^4Drift Mode: ^2Enabled' } })
    else
        -- Restore original handling values
        ResetVehicleHandling(GetVehiclePedIs(PlayerPedId()))
        
        TriggerEvent('chat:addMessage', { args = { '^4Drift Mode: ^1Disabled' } })
    end
end)

AddEventHandler('playerSpawned', function()
    driftModeEnabled = false
end)

AddEventHandler('vehicleExit', function()
    driftModeEnabled = false
end)

RegisterCommand('drift', function(source, args, rawCommand)
    TriggerEvent('ToggleDriftMode')
end, false)
