Scriptname SDM_VaeloriaSummonScript extends Quest  

Activator Property SummonTargetFXActivator  Auto
Actor Property PlayerREF Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable Property SDM_VaeloriaIsSummoned  auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
OCR_PrivateCellsUtil Property Util Auto
ObjectReference Property SDM_VaeloriaInventory  Auto
ReferenceAlias Property Alias_VaeloriaSummon  Auto

function Camp(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaSummonScript).Camp(akspeaker)
    Util.FollowerCamping(actor1)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction

function CombatEndResults(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaSummonScript).CombatEndResults(akspeaker)
    int currentrank = actor1.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentrank < 100
        int newrank = currentrank + 1
        actor1.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
        MiscUtil.PrintConsole("Vaeloria's Intimacy value was " + currentrank + " and is now " + newrank)
        debug.notification("Intimacy with Vaeloria has increased.")
        if currentrank < 10 && newrank >= 10
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 20 && newrank >= 20
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 30 && newrank >= 30
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 40 && newrank >= 40
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 50 && newrank >= 50
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        endif
    endif
    int playerLevel = PlayerREF.GetLevel()
    float xpGain = CalculateXPGain(playerLevel)
    Game.AdvanceSkill("Conjuration", xpGain)
endfunction

float function CalculateXPGain(int playerLevel)
    float baseXP = 100.0
    float scalingFactor = 1.5
    float xpGain = baseXP + (scalingFactor * playerLevel) / (1 + 0.01 * playerLevel)
    return xpGain
endfunction

Function Dismiss(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaSummonScript).Dismiss(akspeaker)
    Alias_VaeloriaSummon.Clear()
    SDM_VaeloriaIsSummoned.SetValue(0)
    actor1.PlaceAtMe(SummonTargetFXActivator, 1)
    Utility.Wait(0.33)
    actor1.MoveToMyEditorLocation()
    actor1.SetPlayerTeammate(0)
endfunction

function Favor(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaSummonScript).Favor(akspeaker)
    actor1.SetDoingFavor()
endfunction

function Inventory()
    ;(GetOwningQuest() as SDM_VaeloriaSummonScript).Inventory()
    SDM_VaeloriaInventory.Activate(PlayerREF)
endfunction