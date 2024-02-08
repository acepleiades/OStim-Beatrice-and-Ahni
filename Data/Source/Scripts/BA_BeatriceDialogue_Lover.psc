Scriptname BA_BeatriceDialogue_Lover extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
Quest Property OCR_OStimScenesUtilQST Auto
Quest Property OCR_OStimSequencesUtilQST Auto
Quest Property OCR_PrivateCellsUtilQST  Auto

Function Flirt(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).Flirt(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Court(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CourtNPC(actor1)
    endif
endfunction

Function Caress(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).Caress(akspeaker)
    int r = Utility.RandomInt(0, 5)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressCheekStroke(actor1)
    ElseIf r == 1
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressCheekStrokeNPC(actor1)
    ElseIf r == 2
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHoldHands(actor1)
    ElseIf r == 3
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHoldHandsNPC(actor1)
    ElseIf r == 4
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHug(actor1)
    ElseIf r == 5
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHugNPC(actor1)
    endif
endfunction

Function Kiss(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).Kiss(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1NPC(actor1)
    endif
endfunction

function InnVisit(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).InnVisit(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).GoToPrivateCell_Inn(actor1)
endfunction

Function UnrestrictedActions(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).UnrestrictedActions(akspeaker)
    (OCR_OStimScenesUtilQST as OCR_OStimScenesUtil).OCR_StartScene(actor1)
endfunction

Function TalkIntoAcceptingMultiplePartners(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).TalkIntoAcceptingMultiplePartners(akspeaker)
    Debug.Notification("Beatrice has come to accept you seeing other partners.")
    actor1.AddToFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
    actor1.AddToFaction(OCR_OStimScenes_3PPCandidateFaction)
endfunction