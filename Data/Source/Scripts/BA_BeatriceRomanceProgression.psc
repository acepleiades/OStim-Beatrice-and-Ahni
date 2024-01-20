Scriptname BA_BeatriceRomanceProgression extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_GiftGiven  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property OCR_RomanceProgression_NoMoreInThisInstance  Auto
ObjectReference Property Gift Auto
Quest Property BA_BeatriceDialogue_RomanceProgressionQST  Auto

Function ResponsePositive(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ResponsePositive(akspeaker)
    int BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if BeatriceIntimacy < 100
        int newIntimacy = BeatriceIntimacy + 8
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Beatrice has greatly increased.")
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
endFunction

Function ResponseNeutral(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ResponseNeutral(akspeaker)
    int BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if BeatriceIntimacy < 100
        int newIntimacy = BeatriceIntimacy + 4
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        Debug.Notification("Intimacy with Beatrice has increased.")
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
endFunction

Function ResponseUpset(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ResponseUpset(akspeaker)
    BA_BeatriceDialogue_RomanceProgression_Blockage.SetValue(1)
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Beatrice is unhappy.")
endFunction

Function BeatriceGift()
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).BeatriceGift()
    if BA_BeatriceDialogue_RomanceProgression_GiftGiven.GetValue() == 0
        Game.GetPlayer().AddItem(Gift)
        BA_BeatriceDialogue_RomanceProgression_GiftGiven.SetValue(1)
    endif
endfunction

Function ConfessionAccept(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ConfessionAccept(akspeaker)
    OCR_RomanceProgression_NoMoreInThisInstance.SetValue(1)
    actor1.AddToFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
    Debug.Notification("Beatrice has become your committed lover.")
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function ConfessionReject()
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ConfessionReject()
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(100)
endFunction

Function Apologize()
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).Apologize()
    BA_BeatriceDialogue_RomanceProgression_Blockage.SetValue(0)
    BA_BeatriceDialogue_RomanceProgression_HasApologized.SetValue(1)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Debug.Notification("Beatrice accepts your apology.")
endFunction

function AcceptMultiplePartners(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).AcceptMultiplePartners(akspeaker)
    actor1.AddToFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
    actor1.AddToFaction(OCR_OStimScenes_3PPCandidateFaction)
endfunction