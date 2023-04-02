ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.Trigger, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    print("-------------------------------------")
    print("^5[Started] ^7- Ammunation - ^1Lawk#0008")
    print("^5Discord : ^7discord.gg^1/lpdev")
    print("-------------------------------------")
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(10)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

open = false
local menuarmurerie = RageUI.CreateMenu(Config.Titre, "Voici mes offres ! :")
local armesblanches = RageUI.CreateSubMenu(menuarmurerie, Config.Titre, "Nos armes Blanches :")
local armeslourdes = RageUI.CreateSubMenu(menuarmurerie, Config.Titre, "Nos armes Lourdes :")
local item = RageUI.CreateSubMenu(menuarmurerie, Config.Titre, "Nos Items :")
local teststaff = RageUI.CreateSubMenu(menuarmurerie, Config.Titre, "Test Staff :")

menuarmurerie.Closed = function()
    open = false
end

menuarmurerie:SetRectangleBanner(Config.CouleurMenu.R, Config.CouleurMenu.G, Config.CouleurMenu.B, Config.CouleurMenu.Opacity)
armesblanches:SetRectangleBanner(Config.CouleurMenu.R, Config.CouleurMenu.G, Config.CouleurMenu.B, Config.CouleurMenu.Opacity)
armeslourdes:SetRectangleBanner(Config.CouleurMenu.R, Config.CouleurMenu.G, Config.CouleurMenu.B, Config.CouleurMenu.Opacity)
item:SetRectangleBanner(Config.CouleurMenu.R, Config.CouleurMenu.G, Config.CouleurMenu.B, Config.CouleurMenu.Opacity)

Citizen.CreateThread(function()
    if Config.Accessoires == false then
        print("[Desactived] - Accessoires - Ammunation")
    end
end)

function OpenAmmunationMenu()
    if open then
        open = false 
        RageUI.Visible(menuarmurerie, false)
        return 
    else
        open = true
        RageUI.Visible(menuarmurerie, true)
        CreateThread(function()
            while open do
                ESX.ShowHelpNotification("")
                
                RageUI.IsVisible(menuarmurerie, function()   
                    if Config.PPA == true then
                        if ppa == true then      
                            RageUI.Separator("PPA : ~g~Acquis~s~")
                        else
                            RageUI.Separator("PPA : ~r~Non Acquis~s~")
                        end
                        if Config.BuyPPA == true then
                            if ppa == false then 
                                RageUI.Line()
                                RageUI.Button("Acheter le PPA", nil, {RightLabel = Config.PrixPPA.. " ~g~$"}, true, {
                                    onSelected = function()
                                        TriggerServerEvent('lawk:buyppa', Config.PrixPPA)
                                    end,
                                })
                                RageUI.Line()
                            end
                        end
                        RageUI.Button("Armes Blanches", nil, {RightLabel = "→→→"}, true, {}, armesblanches)  
                        ESX.TriggerServerCallback('lawk:VerifierLicense', function(cb)            
                            if cb then
                                ppa = true 
                            else 
                                ppa = false   
                            end
                        end)
                        if ppa == true then    
                            RageUI.Button("Armes Lourdes", nil, {RightLabel = "→→→"}, true, {}, armeslourdes)
                        else
                            RageUI.Button("Armes Lourdes", nil, {RightLabel = "🔒"}, true, {
                                onSelected = function()
                                    ESX.ShowNotification("~r~Vous n'avez pas le ~b~PPA~r~ !")
                                end,
                            })
                        end
                    else
                        RageUI.Button("Armes Blanches", nil, {RightLabel = "→→→"}, true, {}, armesblanches)
                        RageUI.Button("Armes Lourdes", nil, {RightLabel = "→→→"}, true, {}, armeslourdes)
                    end
                    if Config.Accessoires == true then    
                        RageUI.Button("Nos Accessoires", nil, {RightLabel = "→→→"}, true, {}, item)
                    end
                end)
                
                RageUI.IsVisible(armesblanches, function()
                    if Config.ArmesEnItem == false then   
                        for k,v in pairs(Config.ArmesBlanches) do
                            RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent('lawk:buyarmesblanches', v.armes, v.prix, v.nom)
                                end,
                            })
                        end
                    else
                        for k,v in pairs(Config.ArmesBlanches) do
                            RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent('lawk:buyarmesblancheitem', v.armes, v.prix, v.nom)
                                end,
                            })
                        end
                    end
                end)
                
                RageUI.IsVisible(armeslourdes, function()
                    if Config.ArmesEnItem == false then    
                        for k,v in pairs(Config.ArmesLourdes) do
                            RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent('lawk:buyarmeslourdes', v.armes, v.prix, v.nom)
                                end,
                            })
                        end
                    else
                        for k,v in pairs(Config.ArmesLourdes) do
                            RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent('lawk:buyarmeslourdeitem', v.armes, v.prix, v.nom)
                                end,
                            })
                        end
                    end
                end)
                
                RageUI.IsVisible(item, function()
                    for k,v in pairs(Config.Items) do
                        RageUI.Button(v.nom, nil, {RightLabel = "~g~"..v.prix.."$"}, true, {
                            onSelected = function()
                                local nbre = KeyboardInput("Combien en voulez vous acheter ?", "", 100)
                                TriggerServerEvent('lawk:buyitems', v.nom, v.item, v.prix, nbre)
                            end,
                        })
                    end
                end)
                Wait(0)
            end 
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        local InZone = false
        local playerPos = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.ArmureriePosition) do
            local distance = GetDistanceBetweenCoords(playerPos, v.pos.x, v.pos.y, v.pos.z, true)
            if distance < 10 then
                DrawMarker(2, v.pos.x, v.pos.y, v.pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 0, 0, 200, Config.MarkerSaute, nil, nil, Config.MarkerTourne, nil, nil, 0)
                InZone = true
                if distance < 2 then
                    ESX.ShowHelpNotification("Appuyer sur ~input_context~ ~s~pour accéder a l\'Ammunation", 1)
                    if IsControlJustPressed(1, 38) then
                        OpenAmmunationMenu()
                    end
                end
            end
        end
        if not InZone then
            Wait(2500)
        else
            Wait(1)
        end
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.ArmureriePosition) do
        local blip = AddBlipForCoord(v.pos.x, v.pos.y, v.pos.z)
        SetBlipSprite(blip, 110)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 1)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Ammunation")
        EndTextCommandSetBlipName(blip)
    end
end)
    
RegisterCommand("armurerie", function()
    OpenAmmunationMenu()
end)