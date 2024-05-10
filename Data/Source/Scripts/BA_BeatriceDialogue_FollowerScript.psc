Scriptname BA_BeatriceDialogue_FollowerScript extends Quest  

Actor Property Ahni Auto
Actor Property playerRef Auto
GlobalVariable Property BA_IsFollowing Auto
GlobalVariable Property BA_IsWaiting Auto
GlobalVariable Property GameDaysPassed  Auto
GlobalVariable property BA_ShownMSG_PersonalInventory auto
GlobalVariable property GameDay auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
Message property BA_MSG_PersonalInventory Auto
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
    BeatriceFollowerAlias.Clear()
    AhniFollowerAlias.Clear()
    BeatriceWaitAlias.Clear()
    AhniWaitAlias.Clear()
    BA_IsFollowing.SetValue(0)
    BA_IsWaiting.SetValue(0)
endfunction

function DismissIntoPlayerHome(actor actor1, string HomeLocation)
    if HomeLocation == "Whiterun"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Whiterun")
        SandboxLocationAlias_Whiterun.ForceRefTo(actor1)
    elseif HomeLocation == "Windhelm"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Windhelm")
        SandboxLocationAlias_Windhelm.ForceRefTo(actor1)
    elseif HomeLocation == "Riften"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Riften")
        SandboxLocationAlias_Riften.ForceRefTo(actor1)
    elseif HomeLocation == "Solitude"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Solitude")
        SandboxLocationAlias_Solitude.ForceRefTo(actor1)
    elseif HomeLocation == "Markarth"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Markarth")
        SandboxLocationAlias_Markarth.ForceRefTo(actor1)
    elseif HomeLocation == "Hjaalmarch"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Hjaalmarch")
        SandboxLocationAlias_Hjaalmarch.ForceRefTo(actor1)
    elseif HomeLocation == "Falkreath"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Falkreath")
        SandboxLocationAlias_Falkreath.ForceRefTo(actor1)
    elseif HomeLocation == "Pale"
        ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).DismissIntoPlayerHome(akspeaker, "Pale")
        SandboxLocationAlias_Pale.ForceRefTo(actor1)
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

function PersonalInventory(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).PersonalInventory(akspeaker)
    if BA_ShownMSG_PersonalInventory.GetValue() == 0
        BA_MSG_PersonalInventory.Show()
        BA_ShownMSG_PersonalInventory.SetValue(1)
    endif
    actor1.ShowGiftMenu(false)
endfunction

function SetFollower(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).SetFollower(akspeaker)
    SandboxLocationAlias_Whiterun.Clear()
    SandboxLocationAlias_Windhelm.Clear()
    SandboxLocationAlias_Riften.Clear()
    SandboxLocationAlias_Solitude.Clear()
    SandboxLocationAlias_Markarth.Clear()
    SandboxLocationAlias_Hjaalmarch.Clear()
    SandboxLocationAlias_Falkreath.Clear()
    SandboxLocationAlias_Pale.Clear()
    actor1.SetPlayerTeammate()
    Ahni.SetPlayerTeammate()
    BeatriceFollowerAlias.ForceRefTo(actor1)
    AhniFollowerAlias.ForceRefTo(Ahni)
    BA_IsFollowing.SetValue(1)
endfunction

function Wait(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).Wait(akspeaker)
    BeatriceXMarker.MoveTo(actor1)
    BeatriceWaitAlias.ForceRefTo(actor1)
    AhniWaitAlias.ForceRefTo(Ahni)
    BA_IsWaiting.SetValue(1)
endfunction

;Notifications for the feature being restricted

Function WaitRestricted()
    ;(GetOwningQuest() as BA_BeatriceDialogue_FollowerScript).WaitRestricted()
    Debug.Notification("You cannot have Beatrice and Ahni wait in this location.")
endfunction