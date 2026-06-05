-- Among Us Cheat Script
-- Funktionen: Imposter Reveal, NoClip, Unsichtbarkeit, God Mode

local ImposterReveal = false
local NoClip = false
local Invisible = false
local GodMode = false

-- Hauptfunktionen
function ShowImposters()
    if ImposterReveal then
        -- Zeigt alle Imposter im Spiel rot markiert
        for _, player in ipairs(GameData.AllPlayers) do
            if player.IsImpostor then
                player.ColorId = 0  -- Rot
            end
        end
    end
end

function EnableNoClip()
    if NoClip then
        -- Ermöglicht das Durchgehen von Wänden
        PlayerControl.CanMove = true
        PlayerControl.Collider.enabled = false
    else
        PlayerControl.Collider.enabled = true
    end
end

function SetInvisibility()
    if Invisible then
        -- Macht den Spieler unsichtbar für andere
        PlayerControl.Visible = false
    else
        PlayerControl.Visible = true
    end
end

function EnableGodMode()
    if GodMode then
        -- Verhindert, dass der Spieler getötet werden kann
        PlayerControl.CanBeKilled = false
    else
        PlayerControl.CanBeKilled = true
    end
end

-- GUI-Steuerung
function CreateMenu()
    local menu = MenuBuilder.New("Among Us Cheat Menu")
    
    menu.AddToggle("Imposter Reveal", function(value)
        ImposterReveal = value
        ShowImposters()
    end)
    
    menu.AddToggle("NoClip", function(value)
        NoClip = value
        EnableNoClip()
    end)
    
    menu.AddToggle("Invisible", function(value)
        Invisible = value
        SetInvisibility()
    end)
    
    menu.AddToggle("God Mode", function(value)
        GodMode = value
        EnableGodMode()
    end)
    
    menu.Show()
end

-- Initialisierung
CreateMenu()

-- Update-Schleife
function Update()
    ShowImposters()
    EnableNoClip()
    SetInvisibility()
    EnableGodMode()
end

-- Tastaturkürzel
function OnKeyPress(key)
    if key == KeyCode.F1 then
        ImposterReveal = not ImposterReveal
    elseif key == KeyCode.F2 then
        NoClip = not NoClip
    elseif key == KeyCode.F3 then
        Invisible = not Invisible
    elseif key == KeyCode.F4 then
        GodMode = not GodMode
    end
end

-- Tastaturkürzel
function OnKeyPress(key)
    if key == KeyCode.F1 then
        ImposterReveal = not ImposterReveal
        print("Imposter Reveal: " .. tostring(ImposterReveal))
    elseif key == KeyCode.F2 then
        NoClip = not NoClip
        print("NoClip: " .. tostring(NoClip))
        EnableNoClip()
    elseif key == KeyCode.F3 then
        Invisible = not Invisible
        print("Invisible: " .. tostring(Invisible))
        SetInvisibility()
    elseif key == KeyCode.F4 then
        GodMode = not GodMode
        print("God Mode: " .. tostring(GodMode))
        EnableGodMode()
    elseif key == KeyCode.F5 then
        -- Beenden des Skripts
        print("Skript wird beendet")
        return false
    end
end

-- Erweiterte Funktionen
function SpeedHack(speed)
    -- Erhöht die Bewegungsgeschwindigkeit
    PlayerControl.moveSpeed = speed
end

function KillCooldown(seconds)
    -- Setzt den Cooldown für Tötungen
    PlayerControl.killTimer = seconds
end

function CompleteAllTasks()
    -- Schließt alle Aufgaben sofort ab
    for _, task in ipairs(PlayerControl.myTasks) do
        task.Complete()
    end
end

function SabotageSystem(systemType)
    -- Sabotiert ein System
    local system = SystemType.__CastFrom(systemType)
    ShipStatus.Instance.RpcRepairSystem(system, 0)
end

function VentTeleport()
    -- Teleportiert zum nächsten Lüftungsschacht
    local vents = ShipStatus.Instance.AllVents
    local closestVent = nil
    local closestDistance = float.MaxValue
    
    for _, vent in ipairs(vents) do
        local distance = Vector2.Distance(PlayerControl.GetTruePosition(), vent.transform.position)
        if distance < closestDistance then
            closestDistance = distance
            closestVent = vent
        end
    end
    
    if closestVent then
        PlayerControl.NetTransform.RpcSnapTo(closestVent.transform.position)
    end
end

-- Erweiterte Tastaturkürzel
function OnKeyPressExtended(key)
    if key == KeyCode.F6 then
        -- Geschwindigkeit erhöhen
        SpeedHack(3.0)
        print("Geschwindigkeit erhöht")
    elseif key == KeyCode.F7 then
        -- Kill Cooldown auf 0 setzen
        KillCooldown(0)
        print("Kill Cooldown auf 0 gesetzt")
    elseif key == KeyCode.F8 then
        -- Alle Aufgaben abschließen
        CompleteAllTasks()
        print("Alle Aufgaben abgeschlossen")
    elseif key == KeyCode.F9 then
        -- Zufälliges System sabotieren
        local randomSystem = math.random(0, 4)
        SabotageSystem(randomSystem)
        print("System sabotiert")
    elseif key == KeyCode.F10 then
        -- Zum nächsten Lüftungsschacht teleportieren
        VentTeleport()
        print("Zum nächsten Lüftungsschacht teleportiert")
    end
end

-- Kombinierte Tastaturkürzel-Funktion
function OnKeyPressAll(key)
    OnKeyPress(key)
    OnKeyPressExtended(key)
end

-- Haupt-Update-Funktion
function Update()
    if ImposterReveal then
        ShowImposters()
    end
    
    if NoClip then
        EnableNoClip()
    end
    
    if Invisible then
        SetInvisibility()
    end
    
    if GodMode then
        EnableGodMode()
    end
end

-- Initialisierung
function Initialize()
    print("Among Us Cheat Script geladen")
    print("Tastaturkürzel:")
    print("F1 - Imposter Reveal")
    print("F2 - NoClip")
    print("F3 - Unsichtbarkeit")
    print("F4 - God Mode")
    print("F5 - Skript beenden")
    print("F6 - Geschwindigkeit erhöhen")
    print("F7 - Kill Cooldown auf 0")
    print("F8 - Alle Aufgaben abschließen")
    print("F9 - System sabotieren")
    print("F10 - Zum nächsten Lüftungsschacht teleportieren")
end

-- Skript registrieren
Initialize()
