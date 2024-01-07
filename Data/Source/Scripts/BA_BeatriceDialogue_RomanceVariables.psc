Scriptname BA_BeatriceDialogue_RomanceVariables extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_ExcludedFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_Lover_Value_Love  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
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
                Beatrice.RemoveFromFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
                Beatrice.RemoveFromFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
                Beatrice.RemoveFromFaction(OCR_OStimScenes_3PPCandidateFaction)
                Beatrice.SetFactionRank(OCR_Lover_Value_Love, 0)
            endIf
            BA_BeatriceDialogue_RomanceProgression_Reset_Shown.SetValue(1)
        endif
    endif
    int currentRomanceProgressionStage = BA_BeatriceDialogue_RomanceProgressionQST.GetStage()
    MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice's current progression stage is " + currentRomanceProgressionStage)
    float BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentRomanceProgressionStage < 50 ; Before love confession stage
        if BA_BeatriceDialogue_RomanceProgression_Blockage.GetValue() == 0
            int requiredIntimacy = (currentRomanceProgressionStage / 10) * 10 + 10
            if BeatriceIntimacy >= requiredIntimacy && !BA_BeatriceDialogue_RomanceProgressionQST.IsRunning()
                BA_BeatriceDialogue_RomanceProgressionQST.Start()
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(10)
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Beatrice's Romance Progression: progression has just begun and stage is 10.")
                Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
                BA_BeatriceDialogue_RomanceVariablesQST.Stop()
            ElseIf BeatriceIntimacy >= requiredIntimacy
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Beatrice's Romance Progression: progression is currently possible.")
                Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
                BA_BeatriceDialogue_RomanceVariablesQST.Stop()
            else
                MiscUtil.PrintConsole("Beatrice's Romance Progression: progression is not possible because of low Intimacy.")
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
                Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
                BA_BeatriceDialogue_RomanceVariablesQST.Stop()
            endif
            Beatrice.EvaluatePackage()
        ElseIf BA_BeatriceDialogue_RomanceProgression_HasApologized.GetValue() == 1
            HandleUpsetScenarios(Beatrice)
        Else
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires an apology to resume the progression.")
            Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
            BA_BeatriceDialogue_RomanceVariablesQST.Stop()
        endif
    else ; Love confession stages
        if currentRomanceProgressionStage != 70 ; Romance subject is not upset
            HandleCommitmentScenarios(Beatrice, currentRomanceProgressionStage)
        else ; Romance subject is upset
            HandleUpsetScenarios(Beatrice)
        endif
    endif
endFunction

function HandleCommitmentScenarios(actor Beatrice, int currentRomanceProgressionStage)
    (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
    if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
        (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
        if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
            CheckAttractionAndSetStage(Beatrice, 80)
        Else
            BA_BeatriceDialogue_RomanceProgressionQST.Reset()
            BA_BeatriceDialogue_RomanceProgressionQST.SetStage(50) ; Normal love confession
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Beatrice's Romance Progression: progression stage set to 50.")
            Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
            BA_BeatriceDialogue_RomanceVariablesQST.Stop()
        endif
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires the player character to not be in an exclusive relationship to resume the romance progression.")
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function HandleUpsetScenarios(actor Beatrice)
    float BeatriceAttraction = (BA_BeatriceDialogue_RomanceVariablesQST as OCR_AttractionUtil).CalculateNPCAttraction(Beatrice)
    MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice's calculated attraction is" + BeatriceAttraction)
    float BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if BeatriceAttraction >= 1.3 && BeatriceIntimacy >= 50
        (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
        if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
            (BA_BeatriceDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
            if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
                BA_BeatriceDialogue_RomanceProgressionQST.Reset()
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(90)
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Beatrice's Romance Progression: progression stage set to 90.")
                Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
                BA_BeatriceDialogue_RomanceVariablesQST.Stop()
            Else
                BA_BeatriceDialogue_RomanceProgressionQST.Reset()
                BA_BeatriceDialogue_RomanceProgressionQST.SetStage(70)
                BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Beatrice's Romance Progression: progression stage set to 70.")
                Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
                BA_BeatriceDialogue_RomanceVariablesQST.Stop()
            endif
        Else
            BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires the player character to not be in an exclusive relationship to resume the progression.")
            Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
            BA_BeatriceDialogue_RomanceVariablesQST.Stop()
        endif
    ElseIf BeatriceAttraction < 1.3
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires the player character to be more attractive to resume the progression.")
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires higher Intimacy to resume the progression.")
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function CheckAttractionAndSetStage(actor Beatrice, int stage)
    float BeatriceAttraction = (BA_BeatriceDialogue_RomanceVariablesQST as OCR_AttractionUtil).CalculateNPCAttraction(Beatrice)
    MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice's calculated attraction is" + BeatriceAttraction)
    float BeatriceIntimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if BeatriceAttraction >= 1.15 && BeatriceIntimacy >= 50
        BA_BeatriceDialogue_RomanceProgressionQST.Reset()
        BA_BeatriceDialogue_RomanceProgressionQST.SetStage(stage)
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Romance progression stage set to " + stage)
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    ElseIf BeatriceAttraction < 1.15
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires the player character to be more attractive to resume the progression.")
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    Else
        BA_BeatriceDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Beatrice's Romance Progression: Beatrice requires higher Intimacy to resume the progression.")
        Debug.Notification("BA_BeatriceDialogue_RomanceVariablesQST has stopped.")
        BA_BeatriceDialogue_RomanceVariablesQST.Stop()
    endif
endFunction