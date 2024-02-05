Scriptname BA_AhniRomanceProgression extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property OCR_RomanceProgression_NoMoreInThisInstance  Auto
OCR_OStimScenesUtil Property Util Auto
Quest Property BA_AhniDialogue_RomanceProgressionQST  Auto
ReferenceAlias Property Alias_Ahni  Auto

Function ResponsePositive(actor Ahni)
    ;(GetOwningQuest() as BA_AhniRomanceProgression).ResponsePositive(akspeaker)
    int AhniIntimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if AhniIntimacy < 100
        int newIntimacy = AhniIntimacy + 8
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Ahni.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Ahni has greatly increased.")
    endif
    int currentRomanceProgressionStage = BA_AhniDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_AhniDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Ahni.Clear()
endFunction

Function ResponseNeutral(actor Ahni)
    ;(GetOwningQuest() as BA_AhniRomanceProgression).ResponseNeutral(akspeaker)
    int AhniIntimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if AhniIntimacy < 100
        int newIntimacy = AhniIntimacy + 4
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Ahni.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Ahni has increased.")
    endif
    int currentRomanceProgressionStage = BA_AhniDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_AhniDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Ahni.Clear()
endFunction

Function ResponseUnhappy(actor Ahni)
    ;(GetOwningQuest() as BA_AhniRomanceProgression).ResponseUnhappy(akspeaker)
    BA_AhniDialogue_RomanceProgression_Blockage.SetValue(1)
    int currentRomanceProgressionStage = BA_AhniDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_AhniDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Ahni dislikes your response.")
    Alias_Ahni.Clear()
endFunction

Function AhniRP40Scene(actor Ahni)
    ;(GetOwningQuest() as BA_AhniRomanceProgression).AhniRP40Scene(akspeaker)
    Util.OCR_StartScene2P(Ahni)
endfunction

Function ConfessionAccept(actor actor1)
    ;(GetOwningQuest() as BA_AhniRomanceProgression).ConfessionAccept(akspeaker)
    OCR_RomanceProgression_NoMoreInThisInstance.SetValue(1)
    actor1.AddToFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
    actor1.AddToFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
    actor1.AddToFaction(OCR_OStimScenes_3PPCandidateFaction)
    Debug.Notification("Ahni has become your committed lover.")
    BA_AhniDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function ConfessionReject()
    ;(GetOwningQuest() as BA_AhniRomanceProgression).ConfessionReject()
    BA_AhniDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function Apologize()
    ;(GetOwningQuest() as BA_AhniRomanceProgression).Apologize()
    BA_AhniDialogue_RomanceProgression_Blockage.SetValue(0)
    BA_AhniDialogue_RomanceProgression_HasApologized.SetValue(1)
    BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Ahni accepts your apology.")
    Alias_Ahni.Clear()
endFunction