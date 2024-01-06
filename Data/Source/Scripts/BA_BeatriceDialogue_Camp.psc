Scriptname BA_BeatriceDialogue_Camp extends Quest  

OCR_PrivateCellsUtil Property Util Auto

function Camp(actor actor1)
	;(GetOwningQuest() as BA_BeatriceDialogue_Camp).Camp(akspeaker)
	Util.FollowerCamping(actor1)
endfunction