Scriptname SDM_AdrietteDialogue_FollowerScript extends Quest  

Actor Property playerRef Auto
Faction Property CurrentFollowerFaction  Auto
GlobalVariable Property SDM_Adriette_IsFollowing Auto
GlobalVariable Property SDM_Adriette_IsWaiting Auto
GlobalVariable Property GameDaysPassed  Auto
GlobalVariable property GameDay auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
ObjectReference Property SDM_AdrietteInventory  Auto
ObjectReference Property SDM_AdrietteXMarker  Auto
Quest Property OCR_PrivateCellsUtilQST  Auto
ReferenceAlias Property AdrietteFollowerAlias Auto
ReferenceAlias Property AdrietteWaitAlias Auto


function Camp(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Camp(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).FollowerCamping(actor1)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction

function Dismiss(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Dismiss(akspeaker)
    actor1.SetPlayerTeammate(false)
    actor1.SetFactionRank(CurrentFollowerFaction, 0)
    AdrietteFollowerAlias.Clear()
    AdrietteWaitAlias.Clear()
    SDM_Adriette_IsFollowing.SetValue(0)
    SDM_Adriette_IsWaiting.SetValue(0)
endfunction

function Favor(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Favor(akspeaker)
    actor1.SetDoingFavor()
endfunction

function Follow()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Follow()
    SDM_AdrietteXMarker.Reset()
    AdrietteWaitAlias.Clear()
    SDM_Adriette_IsWaiting.SetValue(0)
endfunction

function Inventory()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Inventory()
    SDM_AdrietteInventory.Activate(PlayerREF)
endfunction

function SetFollower(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).SetFollower(akspeaker)
    actor1.SetPlayerTeammate()
    actor1.SetFactionRank(CurrentFollowerFaction, 1)
    AdrietteFollowerAlias.ForceRefTo(actor1)
    SDM_Adriette_IsFollowing.SetValue(1)
endfunction

function Wait(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Wait(akspeaker)
    SDM_AdrietteXMarker.MoveTo(actor1)
    AdrietteWaitAlias.ForceRefTo(actor1)
    SDM_Adriette_IsWaiting.SetValue(1)
endfunction

;Notifications for the feature being restricted

Function WaitRestricted()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).WaitRestricted()
    Debug.Notification("You cannot have Adriette wait in this location.")
endfunction