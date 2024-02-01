Scriptname SDM_VaeloriaSummonScript extends Quest  

Activator Property SummonTargetFXActivator  Auto
Actor Property PlayerREF Auto
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

Function Dismiss(actor actor1)
	;(GetOwningQuest() as SDM_VaeloriaSummonScript).Dismiss(akspeaker)
	Alias_VaeloriaSummon.Clear()
	SDM_VaeloriaIsSummoned.SetValue(0)
	Utility.Wait(1)
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