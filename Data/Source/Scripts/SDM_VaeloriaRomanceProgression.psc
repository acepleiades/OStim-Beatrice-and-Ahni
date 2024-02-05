Scriptname SDM_VaeloriaRomanceProgression extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property OCR_RomanceProgression_NoMoreInThisInstance  Auto
Quest Property SDM_VaeloriaDialogue_RomanceProgressionQST  Auto
ReferenceAlias Property Alias_Vaeloria  Auto

Function ResponsePositive(actor Vaeloria)
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ResponsePositive(akspeaker)
    int VaeloriaIntimacy = Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if VaeloriaIntimacy < 100
        int newIntimacy = VaeloriaIntimacy + 8
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Vaeloria.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Vaeloria has greatly increased.")
    endif
    int currentRomanceProgressionStage = SDM_VaeloriaDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Vaeloria.Clear()
endFunction

Function ResponseNeutral(actor Vaeloria)
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ResponseNeutral(akspeaker)
    int VaeloriaIntimacy = Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if VaeloriaIntimacy < 100
        int newIntimacy = VaeloriaIntimacy + 4
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Vaeloria.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Vaeloria has increased.")
    endif
    int currentRomanceProgressionStage = SDM_VaeloriaDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Vaeloria.Clear()
endFunction

Function ResponseDislike(actor Vaeloria)
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ResponseDislike(akspeaker)
    SDM_VaeloriaDialogue_RomanceProgression_Blockage.SetValue(1)
    int currentRomanceProgressionStage = SDM_VaeloriaDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Vaeloria dislikes your response.")
    Alias_Vaeloria.Clear()
endFunction

Function ResponseDislikeRespect(actor Vaeloria)
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ResponseDislikeRespect(akspeaker)
    int currentRomanceProgressionStage = SDM_VaeloriaDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Vaeloria dislikes, yet respects your response.")
    Alias_Vaeloria.Clear()
endFunction

Function ConfessionAccept(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ConfessionAccept(akspeaker)
    OCR_RomanceProgression_NoMoreInThisInstance.SetValue(1)
    actor1.AddToFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
    actor1.AddToFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
    actor1.AddToFaction(OCR_OStimScenes_3PPCandidateFaction)
    Debug.Notification("Vaeloria has become your committed lover.")
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function ConfessionReject()
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).ConfessionReject()
    SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function Reconcile()
    ;(GetOwningQuest() as SDM_VaeloriaRomanceProgression).Reconcile()
    SDM_VaeloriaDialogue_RomanceProgression_Blockage.SetValue(0)
    SDM_VaeloriaDialogue_RomanceProgression_HasApologized.SetValue(1)
    SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Vaeloria accepts your reconciliation.")
    Alias_Vaeloria.Clear()
endFunction