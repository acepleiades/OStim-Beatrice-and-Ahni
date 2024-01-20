Scriptname BA_AhniDialogue_Camp extends Quest  

GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
OCR_PrivateCellsUtil Property Util Auto

function Camp(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Camp).Camp(akspeaker)
	Util.FollowerCamping(actor1)
	OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction