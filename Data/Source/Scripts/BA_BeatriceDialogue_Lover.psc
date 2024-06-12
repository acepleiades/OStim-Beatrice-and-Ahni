Scriptname BA_BeatriceDialogue_Lover extends Quest  

GlobalVariable Property BA_Cooldown_BeatriceAutoFG_Nonsexual  Auto
GlobalVariable Property BA_Cooldown_BeatriceAutoFG_Sexual  Auto
Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
Message Property BA_BeatriceAutoFG_CfgAuto_NonsexualMSG Auto
Message Property BA_BeatriceAutoFG_CfgAuto_SexualMSG Auto
Quest Property OCR_OStimScenesUtilQST Auto
Quest Property OCR_OStimSequencesUtilQST Auto
Quest Property OCR_PrivateCellsUtilQST  Auto

Message Property BA_MSG_LoverRestricted_Gold Auto
Message Property BA_MSG_LoverRestricted_NoInn Auto
Message Property BA_MSG_LoverRestricted_PrivateLocation Auto

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

Function ManageAutonomousCD()
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).ManageAutonomousCD()
    Int iChoice0 = BA_BeatriceAutoFG_CfgAuto_NonsexualMSG.Show()
    if iChoice0 == 0
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(0.125)
    ElseIf iChoice0 == 1
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(0.250)
    ElseIf iChoice0 == 2
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(0.500)
    ElseIf iChoice0 == 3
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(1.000)
    ElseIf iChoice0 == 4
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(2.000)
    ElseIf iChoice0 == 5
        BA_Cooldown_BeatriceAutoFG_Nonsexual.SetValue(3.000)
    endif
    Int iChoice1 = BA_BeatriceAutoFG_CfgAuto_SexualMSG.Show()
    if iChoice1 == 0
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(0.125)
    ElseIf iChoice1 == 1
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(0.250)
    ElseIf iChoice1 == 2
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(0.500)
    ElseIf iChoice1 == 3
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(1.000)
    ElseIf iChoice1 == 4
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(2.000)
    ElseIf iChoice1 == 5
        BA_Cooldown_BeatriceAutoFG_Sexual.SetValue(3.000)
    endif
endfunction

;Notifications for the feature being restricted

function InnVisitRestricted_Gold()
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).InnVisitRestricted_Gold()
    BA_MSG_LoverRestricted_Gold.Show()
endfunction
function InnVisitRestricted_Location()
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).InnVisitRestricted_Location()
    BA_MSG_LoverRestricted_NoInn.Show()
endfunction
Function UnrestrictedActionsRestricted()
    ;(GetOwningQuest() as BA_BeatriceDialogue_Lover).UnrestrictedActionsRestricted()
    BA_MSG_LoverRestricted_PrivateLocation.Show()
endfunction