Scriptname SDM_VaeloriaDialogue_RomanceVariables extends Quest  

Actor Property PlayerRef Auto
Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_ExcludedFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_Lover_Value_Love  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInExclusiveRelationship  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInNonexclusiveRelationship  Auto
GlobalVariable Property OCR_RomanceProgression_NoMoreInThisInstance  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible  Auto
Keyword Property Vampire  Auto
Quest Property DA10 Auto
Quest Property SDM_VaeloriaDialogue_RomanceProgressionQST  Auto
Quest Property SDM_VaeloriaDialogue_RomanceVariablesQST  Auto
ReferenceAlias Property Alias_VaeloriaRPSandbox  Auto ;From the quest SDM_VaeloriaRomanceProgressionQST

function UpdateRomanceProgressionVariables(actor Vaeloria)
    Alias_VaeloriaRPSandbox.Clear()
    OCR_RomanceProgression_NoMoreInThisInstance.SetValue(0)
    int currentRomanceProgressionStage = SDM_VaeloriaDialogue_RomanceProgressionQST.GetStage()
    MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria's current progression stage is " + currentRomanceProgressionStage)
    float VaeloriaIntimacy = Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentRomanceProgressionStage < 50 ; Before love confession stage
        if SDM_VaeloriaDialogue_RomanceProgression_Blockage.GetValue() == 0
            int requiredIntimacy = currentRomanceProgressionStage
            if requiredIntimacy == 0
                requiredIntimacy = 10
            endif
            if VaeloriaIntimacy >= requiredIntimacy && !SDM_VaeloriaDialogue_RomanceProgressionQST.IsRunning()
                SDM_VaeloriaDialogue_RomanceProgressionQST.Start()
                SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(10)
                SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression has just begun and stage is 10.")
                Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
                SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
            ElseIf VaeloriaIntimacy >= requiredIntimacy
                SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression is currently possible.")
                Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
                SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
            else
                MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression is not possible because of low Intimacy.")
                SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
                Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
                SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
            endif
            Vaeloria.EvaluatePackage()
        ElseIf SDM_VaeloriaDialogue_RomanceProgression_HasApologized.GetValue() == 1
            HandleUpsetScenarios(Vaeloria)
        Else
            SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires an apology to resume the progression.")
            Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
            SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
        endif
    else ; Love confession stages
        if SDM_VaeloriaDialogue_RomanceProgression_Blockage.GetValue() == 1 && SDM_VaeloriaDialogue_RomanceProgression_HasApologized.GetValue() == 1
            ;Ensure that romance progression is at upset stage
            currentRomanceProgressionStage = 70
        endif
        if currentRomanceProgressionStage != 70 ; Romance subject is not upset
            HandleCommitmentScenarios(Vaeloria, currentRomanceProgressionStage)
        else ; Romance subject is upset
            HandleUpsetScenarios(Vaeloria)
        endif
    endif
endFunction

function HandleCommitmentScenarios(actor Vaeloria, int currentRomanceProgressionStage)
    (SDM_VaeloriaDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
    if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
        (SDM_VaeloriaDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
        if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
            CheckAttractionAndSetStage(Vaeloria, 80)
        Else
            SDM_VaeloriaDialogue_RomanceProgressionQST.Reset()
            SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(50) ; Normal love confession
            SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression stage set to 50.")
            Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
            SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
        endif
    Else
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires the player character to not be in an exclusive relationship to resume the romance progression.")
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function HandleUpsetScenarios(actor Vaeloria)
    bool VaeloriaIsKindred
    if PlayerRef.Haskeyword(Vampire) || DA10.IsCompleted()
        VaeloriaIsKindred = 1
    endif
    float VaeloriaIntimacy = Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if VaeloriaIsKindred && VaeloriaIntimacy >= 50
        (SDM_VaeloriaDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
        if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
            (SDM_VaeloriaDialogue_RomanceVariablesQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
            if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
                SDM_VaeloriaDialogue_RomanceProgressionQST.Reset()
                SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(90)
                SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression stage set to 90.")
                Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
                SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
            Else
                SDM_VaeloriaDialogue_RomanceProgressionQST.Reset()
                SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(70)
                SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Vaeloria's Romance Progression: progression stage set to 70.")
                Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
                SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
            endif
        Else
            SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires the player character to not be in an exclusive relationship to resume the progression.")
            SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
        endif
    ElseIf VaeloriaIsKindred == 0
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires the player character to be a vampire of finish Molag Bal's quest to resume the progression.")
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    Else
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires higher Intimacy to resume the progression.")
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function CheckAttractionAndSetStage(actor Vaeloria, int stage)
    bool VaeloriaIsKindred
    if PlayerRef.Haskeyword(Vampire) || DA10.IsCompleted()
        VaeloriaIsKindred = 1
    endif
    float VaeloriaIntimacy = Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if VaeloriaIsKindred && VaeloriaIntimacy >= 50
        SDM_VaeloriaDialogue_RomanceProgressionQST.Reset()
        SDM_VaeloriaDialogue_RomanceProgressionQST.SetStage(stage)
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Romance progression stage set to " + stage)
        Alias_VaeloriaRPSandbox.ForceRefTo(Vaeloria)
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    ElseIf VaeloriaIsKindred == 0
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires the player character to be a vampire of finish Molag Bal's quest to resume the progression.")
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    Else
        SDM_VaeloriaDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Vaeloria's Romance Progression: Vaeloria requires higher Intimacy to resume the progression.")
        SDM_VaeloriaDialogue_RomanceVariablesQST.Stop()
    endif
endFunction