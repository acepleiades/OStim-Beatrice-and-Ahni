Scriptname BA_BeatriceDialogue_RomanceVariables extends Quest  

Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInExclusiveRelationship  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInNonexclusiveRelationship  Auto
Quest Property BA_BeatriceDialogue_RomanceProgressionQST  Auto
Quest Property BA_BeatriceDialogue_RomanceVariablesQST  Auto

function UpdateRomanceProgressionVariables(actor Beatrice)
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    MiscUtil.PrintConsole("SetRomanceProgressionStage: Beatrice's current romance progression stage is " + currentRomanceProgressionStage)
    float BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentRomanceProgressionStage < 50 ; Before love confession stage
        if BA_BeatriceDialogue_RomanceProgression_Blockage.GetValue() == 0
            int requiredIntimacy = (currentRomanceProgressionStage / 10) * 10 + 10
            if BeatriceIntimacy >= requiredIntimacy && !BA_BeatriceDialogue_RomanceProgressionQST.IsRunning()
                BA_BeatriceDialogue_RomanceProgressionQST.Start()
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(10)
                MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is 10.")
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            else
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            endif
            Beatrice.EvaluatePackage()
        ElseIf BA_BeatriceDialogue_RomanceProgression_HasApologized.GetValue() == 1
            BA_BeatriceDialogue_RomanceProgressionQST.SetStage(70)
            MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is 70.")
        endif
    elseIf currentRomanceProgressionStage >= 50 ; Love confession stages
        MiscUtil.PrintConsole("SetRomanceProgressionStage: Beatrice's romance progression stage is at the point of love confessions.")
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        if currentRomanceProgressionStage != 70 ; Not too upset
            HandleCommitmentScenarios(Beatrice, currentRomanceProgressionStage)
        else ; Beatrice was made upset
            HandleUpsetScenarios(Beatrice)
        endif
    endif
    BA_BeatriceDialogue_RomanceVariablesQST.Stop()
endFunction

function HandleCommitmentScenarios(actor Beatrice, int currentRomanceProgressionStage)
    (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
    if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
        (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
        if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
            CheckAttractionAndSetStage(Beatrice, 80)
        Else
            BA_BeatriceDialogue_RomanceProgressionQST.SetStage(50) ; Normal love confession
            MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is 50.")
            BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(1)
        endif
    Else
        BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(0)
    endif
endFunction

function HandleUpsetScenarios(actor Beatrice)
    float BeatriceAttraction = (BA_BeatriceDialogue_RomanceVariablesQST as OCR_AttractionUtil).CalculateNPCAttraction(Beatrice)
    if BeatriceAttraction > 1
        (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
        if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
            (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
            if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(90)
                MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is 90.")
                BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(1)
            Else
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(70)
                MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is 70.")
                BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(1)
            endif
        Else
            BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(0)
        endif
    Else
        BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(0)
    endif
endFunction

function CheckAttractionAndSetStage(actor Beatrice, int stage)
    float BeatriceAttraction = (BA_BeatriceDialogue_RomanceVariablesQST as OCR_AttractionUtil).CalculateNPCAttraction(Beatrice)
    if BeatriceAttraction > 1
        BA_BeatriceDialogue_RomanceProgressionQST.SetStage(stage)
        BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(1)
        MiscUtil.PrintConsole("SetRomanceProgressionStage: Romance progression stage is " + stage)
    Else
        BA_BeatriceDialogue_RomanceProgression_ConfessionAllowed.SetValue(0)
    endif
endFunction