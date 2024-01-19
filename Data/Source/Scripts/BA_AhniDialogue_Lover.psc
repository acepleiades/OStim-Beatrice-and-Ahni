Scriptname BA_AhniDialogue_Lover extends Quest  

Quest Property BA_AhniDialogue_LoverQST Auto
OCR_PrivateCellsUtil Property Util Auto

Function Flirt(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Lover).Flirt(akspeaker)
	int r = Utility.RandomInt(0, 1)
	if r == 0
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).Court(actor1)
	Else
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CourtNPC(actor1)
	endif
endfunction

Function Caress(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Lover).Caress(akspeaker)
	int r = Utility.RandomInt(0, 5)
	if r == 0
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressCheekStroke(actor1)
	ElseIf r == 1
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressCheekStrokeNPC(actor1)
	ElseIf r == 2
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressHoldHands(actor1)
	ElseIf r == 3
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressHoldHandsNPC(actor1)
	ElseIf r == 4
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressHug(actor1)
	ElseIf r == 5
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).CaressHugNPC(actor1)
	endif
endfunction

Function Kiss(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Lover).Kiss(akspeaker)
	int r = Utility.RandomInt(0, 1)
	if r == 0
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).Kiss1(actor1)
	Else
		(BA_AhniDialogue_LoverQST as OCR_OStimSequencesUtil).Kiss1NPC(actor1)
	endif
endfunction

function InnVisit(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Lover).InnVisit(akspeaker)
	Util.GoToPrivateCell_Inn(actor1)
endfunction

Function UnrestrictedActions(actor actor1)
	;(GetOwningQuest() as BA_AhniDialogue_Lover).UnrestrictedActions(akspeaker)
	(BA_AhniDialogue_LoverQST as OCR_OStimScenesUtil).OCR_StartScene(actor1)
endfunction