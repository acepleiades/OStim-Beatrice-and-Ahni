Scriptname BA_BeatriceDialogue_RomanceVariables extends Quest  

Faction Property OCR_Lover_ExcludedFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_Lover_Value_Love  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property BA_BeatriceDialogue_RomanceProgression_Reset_Shown  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInExclusiveRelationship  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInNonexclusiveRelationship  Auto
Message Property BA_BeatriceDialogue_RomanceProgression_Reset Auto
Quest Property BA_BeatriceDialogue_RomanceProgressionQST  Auto
Quest Property BA_BeatriceDialogue_RomanceVariablesQST  Auto

function UpdateRomanceProgressionVariables(actor Beatrice)
    if BA_BeatriceDialogue_RomanceProgression_Reset_Shown.GetValue() == 0
        if Beatrice.GetFactionRank(OCR_Lover_Value_Love) > 0 || Beatrice.IsInFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
            Int iChoice = BA_BeatriceDialogue_RomanceProgression_Reset.Show()
            if iChoice == 0
                Beatrice.AddToFaction(OCR_Lover_ExcludedFaction)
                Beatrice.RemoveFromFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
                Beatrice.SetFactionRank(OCR_Lover_Value_Love, 0)
            endIf
            BA_BeatriceDialogue_RomanceProgression_Reset_Shown.SetValue(1)
        endif
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice's current romance progression stage is " + currentRomanceProgressionStage)
    float BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentRomanceProgressionStage < 50 ; Before love confession stage
        if BA_BeatriceDialogue_RomanceProgression_Blockage.GetValue() == 0
            int requiredIntimacy = (currentRomanceProgressionStage / 10) * 10 + 10
            if BeatriceIntimacy >= requiredIntimacy && !BA_BeatriceDialogue_RomanceProgressionQST.IsRunning()
                BA_BeatriceDialogue_RomanceProgressionQST.Start()
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(10)
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression has just begun and stage is 10.")
            ElseIf BeatriceIntimacy >= requiredIntimacy
                MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression is currently possible.")
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            else
                MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression is not possible because of low Intimacy.")
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            endif
            Beatrice.EvaluatePackage()
        ElseIf BA_BeatriceDialogue_RomanceProgression_HasApologized.GetValue() == 1
            BA_BeatriceDialogue_RomanceProgressionQST.SetStage(70)
            MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression stage set to 70.")
        Else
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice requires an apology to resume the romance progression.")
        endif
    else ; Love confession stages
        MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice's romance progression stage is at the point of love confessions.")
        if currentRomanceProgressionStage != 70 ; Not too upset
            HandleCommitmentScenarios(Beatrice, currentRomanceProgressionStage)
        else ; Beatrice was made upset
            HandleUpsetScenarios(Beatrice)
        endif
    endif
    Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
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
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression stage set to 50.")
        endif
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice requires the player character to not be in an exclusive relationship to resume the romance progression.")
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
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression stage set to 90.")
            Else
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(70)
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression stage set to 70.")
            endif
        Else
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice requires the player character to not be in an exclusive relationship to resume the romance progression.")
        endif
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice requires the player character to be more attractive to resume the romance progression.")
    endif
endFunction

function CheckAttractionAndSetStage(actor Beatrice, int stage)
    float BeatriceAttraction = (BA_BeatriceDialogue_RomanceVariablesQST as OCR_AttractionUtil).CalculateNPCAttraction(Beatrice)
    if BeatriceAttraction > 1
        BA_BeatriceDialogue_RomanceProgressionQST.SetStage(stage)
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
        MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Romance progression stage set to " + stage)
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("BA_BeatriceDialogue_RomanceVariables: Beatrice requires the player character to be more attractive to resume the romance progression.")
    endif
endFunction