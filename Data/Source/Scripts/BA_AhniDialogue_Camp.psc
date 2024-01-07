Scriptname BA_AhniDialogue_Camp extends Quest  

OCR_PrivateCellsUtil Property Util Auto

function Camp(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Camp).Camp(akspeaker)
	Util.FollowerCamping(actor1)
endfunction