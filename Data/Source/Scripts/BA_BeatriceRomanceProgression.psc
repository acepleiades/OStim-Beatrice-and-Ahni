Scriptname BA_BeatriceRomanceProgression extends Quest  

Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_ProgressionPossible  Auto
Quest Property BA_BeatriceDialogue_RomanceProgressionQST  Auto

Function ResponsePositive(actor Beatrice)
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
    BA_BeatriceDialogue_RomanceProgression_Blockage.SetValue(1)
    Debug.Notification("Beatrice is upset.")
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    int newRomanceProgressionStage = currentRomanceProgressionStage + 10
    BA_BeatriceDialogue_RomanceProgressionQST.SetStage(newRomanceProgressionStage)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
endFunction

Function Apologize()
    BA_BeatriceDialogue_RomanceProgression_HasApologized.SetValue(1)
    BA_BeatriceDialogue_RomanceProgression_Blockage.SetValue(0)
    BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
endFunction