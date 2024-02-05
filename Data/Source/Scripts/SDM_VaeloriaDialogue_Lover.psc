Scriptname SDM_VaeloriaDialogue_Lover extends Quest  

Quest Property OCR_OStimScenesUtilQST Auto
Quest Property OCR_OStimSequencesUtilQST Auto
Quest Property OCR_PrivateCellsUtilQST Auto
Quest Property SDM_VaeloriaDialogue_LoverQST Auto

Function Flirt(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).Flirt(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Court(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CourtNPC(actor1)
    endif
endfunction

Function Caress(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).Caress(akspeaker)
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
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).Kiss(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1NPC(actor1)
    endif
endfunction

function InnVisit(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).InnVisit(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).GoToPrivateCell_Inn(actor1)
endfunction

Function UnrestrictedActions(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).UnrestrictedActions(akspeaker)
    (OCR_OStimScenesUtilQST as OCR_OStimScenesUtil).OCR_StartScene(actor1)
endfunction

;Notifications for the feature being restricted

function InnVisitRestricted_Gold()
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).InnVisitRestricted_Gold()
    Debug.Notification("You do not have enough gold.")
endfunction
function InnVisitRestricted_Location()
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).InnVisitRestricted_Location()
    Debug.Notification("Location must be: a town, city, owned house or inn.")
endfunction
Function UnrestrictedActionsRestricted()
    ;(GetOwningQuest() as SDM_VaeloriaDialogue_Lover).UnrestrictedActionsRestricted()
    Debug.Notification("You must be in a private location.")
endfunction