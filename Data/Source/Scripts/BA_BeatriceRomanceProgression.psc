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
ReferenceAlias Property Alias_Beatrice  Auto

Message Property BA_MSG_Beatrice_RPApologize Auto
Message Property BA_MSG_Beatrice_RPConfessionAccept Auto
Message Property BA_MSG_Beatrice_RPResponseNeutral Auto
Message Property BA_MSG_Beatrice_RPResponsePositive Auto
Message Property BA_MSG_Beatrice_RPResponseUpset Auto

Function ResponsePositive(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ResponsePositive(akspeaker)
    int BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if BeatriceIntimacy < 100
        int newIntimacy = BeatriceIntimacy + 8
        if newIntimacy > 100
            newIntimacy = 100
        endif
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        BA_MSG_Beatrice_RPResponsePositive.Show()
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Beatrice.Clear()
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
        BA_MSG_Beatrice_RPResponseNeutral.Show()
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    Alias_Beatrice.Clear()
endFunction

Function ResponseUpset(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).ResponseUpset(akspeaker)
    BA_BeatriceDialogue_RomanceProgression_Blockage.SetValue(1)
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
    BA_MSG_Beatrice_RPResponseUpset.Show()
    Alias_Beatrice.Clear()
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
    BA_MSG_Beatrice_RPConfessionAccept.Show()
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
    BA_MSG_Beatrice_RPApologize.Show()
    Alias_Beatrice.Clear()
endFunction

function AcceptMultiplePartners(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceRomanceProgression).AcceptMultiplePartners(akspeaker)
    actor1.AddToFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
    actor1.AddToFaction(OCR_OStimScenes_3PPCandidateFaction)
endfunction