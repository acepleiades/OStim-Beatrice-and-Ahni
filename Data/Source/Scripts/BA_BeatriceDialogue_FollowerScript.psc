Scriptname BA_BeatriceDialogue_FollowerScript extends Quest  

Actor Property Ahni Auto
Actor Property Beatrice Auto
Actor Property playerRef Auto
Faction Property CurrentFollowerFaction  Auto
GlobalVariable Property BA_IsFollowing Auto
GlobalVariable Property BA_IsWaiting Auto
GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property PlayerFollowerCount Auto
GlobalVariable property GameDay auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
ObjectReference Property BA_BeatriceAhniInventory  Auto
ObjectReference Property BeatriceXMarker  Auto
Quest Property OCR_PrivateCellsUtilQST  Auto
ReferenceAlias Property AhniFollowerAlias Auto
ReferenceAlias Property AhniWaitAlias Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property BeatriceWaitAlias Auto
ReferenceAlias Property SandboxLocationAlias_Falkreath  Auto
ReferenceAlias Property SandboxLocationAlias_Hjaalmarch  Auto
ReferenceAlias Property SandboxLocationAlias_Markarth  Auto
ReferenceAlias Property SandboxLocationAlias_Pale  Auto
ReferenceAlias Property SandboxLocationAlias_Riften  Auto
ReferenceAlias Property SandboxLocationAlias_Solitude  Auto
ReferenceAlias Property SandboxLocationAlias_Whiterun  Auto
ReferenceAlias Property SandboxLocationAlias_Windhelm  Auto


function Camp(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Camp(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).FollowerCamping(actor1)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction

function Dismiss(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Dismiss(akspeaker)
    actor1.SetPlayerTeammate(false)
    Ahni.SetPlayerTeammate(false)
    actor1.SetFactionRank(CurrentFollowerFaction, 0)
    Ahni.SetFactionRank(CurrentFollowerFaction, 0)
    BeatriceFollowerAlias.Clear()
    AhniFollowerAlias.Clear()
    BeatriceWaitAlias.Clear()
    AhniWaitAlias.Clear()
    PlayerFollowerCount.SetValue(0)
    BA_IsFollowing.SetValue(0)
    BA_IsWaiting.SetValue(0)
endfunction

function DismissIntoPlayerHome(actor actor1, string HomeLocation)
    if HomeLocation == "Whiterun"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Whiterun")
        SandboxLocationAlias_Whiterun.ForceRefTo(Beatrice)
    elseif HomeLocation == "Windhelm"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Windhelm")
        SandboxLocationAlias_Windhelm.ForceRefTo(Beatrice)
    elseif HomeLocation == "Riften"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Riften")
        SandboxLocationAlias_Riften.ForceRefTo(Beatrice)
    elseif HomeLocation == "Solitude"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Solitude")
        SandboxLocationAlias_Solitude.ForceRefTo(Beatrice)
    elseif HomeLocation == "Markarth"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Markarth")
        SandboxLocationAlias_Markarth.ForceRefTo(Beatrice)
    elseif HomeLocation == "Hjaalmarch"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Hjaalmarch")
        SandboxLocationAlias_Hjaalmarch.ForceRefTo(Beatrice)
    elseif HomeLocation == "Falkreath"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Falkreath")
        SandboxLocationAlias_Falkreath.ForceRefTo(Beatrice)
    elseif HomeLocation == "Pale"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Pale")
        SandboxLocationAlias_Pale.ForceRefTo(Beatrice)
    endif
    Dismiss(actor1)
    actor1.EvaluatePackage()
endfunction

function Favor(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Favor(akspeaker)
    actor1.SetDoingFavor()
endfunction

function Follow()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Follow()
    BeatriceXMarker.Reset()
    BeatriceWaitAlias.Clear()
    AhniWaitAlias.Clear()
    BA_IsWaiting.SetValue(0)
endfunction

function Inventory()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Inventory()
    BA_BeatriceAhniInventory.Activate(PlayerREF)
endfunction

function SetFollower(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).SetFollower(akspeaker)
    actor1.SetPlayerTeammate()
    Ahni.SetPlayerTeammate()
    actor1.SetFactionRank(CurrentFollowerFaction, 1)
    Ahni.SetFactionRank(CurrentFollowerFaction, 1)
    BeatriceFollowerAlias.ForceRefTo(Beatrice)
    AhniFollowerAlias.ForceRefTo(Ahni)
    PlayerFollowerCount.SetValue(1)
    BA_IsFollowing.SetValue(1)
endfunction

function Wait(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Wait(akspeaker)
    BeatriceXMarker.MoveTo(Beatrice)
    BeatriceWaitAlias.ForceRefTo(Beatrice)
    AhniWaitAlias.ForceRefTo(actor1)
    BA_IsWaiting.SetValue(1)
endfunction

;Notifications for the feature being restricted

Function WaitRestricted()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).WaitRestricted()
    Debug.Notification("You cannot have Beatrice and Ahni wait in this location.")
endfunction