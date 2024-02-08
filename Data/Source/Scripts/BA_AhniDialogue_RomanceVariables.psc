Scriptname BA_AhniDialogue_RomanceVariables extends Quest  

Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_ExcludedFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_Lover_Value_Love  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_Blockage  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_HasApologized  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_ProgressionPossible  Auto
GlobalVariable Property BA_AhniDialogue_RomanceProgression_Reset_Shown  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInExclusiveRelationship  Auto
GlobalVariable Property OCR_Commitment_PlayerIsInNonexclusiveRelationship  Auto
GlobalVariable Property OCR_RomanceProgression_NoMoreInThisInstance  Auto
Message Property BA_AhniDialogue_RomanceProgression_Reset Auto
Quest Property BA_AhniDialogue_RomanceProgressionQST  Auto
Quest Property BA_AhniDialogue_RomanceVariablesQST  Auto
Quest Property OCR_AttractionUtilQST  Auto
Quest Property OCR_CommitmentUtilQST  Auto
ReferenceAlias Property Alias_AhniRPSandbox  Auto ;From the quest SDM_AhniRomanceProgressionQST

function UpdateRomanceProgressionVariables(actor Ahni)
    Alias_AhniRPSandbox.Clear()
    OCR_RomanceProgression_NoMoreInThisInstance.SetValue(0)
    if BA_AhniDialogue_RomanceProgression_Reset_Shown.GetValue() == 0
        if Ahni.GetFactionRank(OCR_Lover_Value_Love) > 0 || Ahni.IsInFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
            Int iChoice = BA_AhniDialogue_RomanceProgression_Reset.Show()
            if iChoice == 0
                Ahni.AddToFaction(OCR_Lover_ExcludedFaction)
                Ahni.RemoveFromFaction(OCR_Lover_AcceptsMultiplePartnersFaction)
                Ahni.RemoveFromFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
                Ahni.RemoveFromFaction(OCR_OStimScenes_3PPCandidateFaction)
                Ahni.SetFactionRank(OCR_Lover_Value_Love, 0)
            endIf
            BA_AhniDialogue_RomanceProgression_Reset_Shown.SetValue(1)
        endif
    endif
    int currentRomanceProgressionStage = BA_AhniDialogue_RomanceProgressionQST.GetStage()
    MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni's current progression stage is " + currentRomanceProgressionStage)
    float AhniIntimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentRomanceProgressionStage < 50 ; Before love confession stage
        if BA_AhniDialogue_RomanceProgression_Blockage.GetValue() == 0
            int requiredIntimacy = currentRomanceProgressionStage
            if requiredIntimacy == 0
                requiredIntimacy = 10
            endif
            if AhniIntimacy >= requiredIntimacy && !BA_AhniDialogue_RomanceProgressionQST.IsRunning()
                BA_AhniDialogue_RomanceProgressionQST.Start()
                BA_AhniDialogue_RomanceProgressionQST.SetStage(10)
                BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Ahni's Romance Progression: progression has just begun and stage is 10.")
                Alias_AhniRPSandbox.ForceRefTo(Ahni)
                BA_AhniDialogue_RomanceVariablesQST.Stop()
            ElseIf AhniIntimacy >= requiredIntimacy
                BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Ahni's Romance Progression: progression is currently possible.")
                Alias_AhniRPSandbox.ForceRefTo(Ahni)
                BA_AhniDialogue_RomanceVariablesQST.Stop()
            else
                MiscUtil.PrintConsole("Ahni's Romance Progression: progression is not possible because of low Intimacy.")
                BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
                BA_AhniDialogue_RomanceVariablesQST.Stop()
            endif
            Ahni.EvaluatePackage()
        ElseIf BA_AhniDialogue_RomanceProgression_HasApologized.GetValue() == 1
            HandleUpsetScenarios(Ahni)
        Else
            BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires an apology to resume the progression.")
            BA_AhniDialogue_RomanceVariablesQST.Stop()
        endif
    else ; Love confession stages
        if BA_AhniDialogue_RomanceProgression_Blockage.GetValue() == 1 && BA_AhniDialogue_RomanceProgression_HasApologized.GetValue() == 1
            ;Ensure that romance progression is at upset stage
            HandleUpsetScenarios(Ahni)
        else
            HandleCommitmentScenarios(Ahni)
        endif
    endif

endFunction

function HandleCommitmentScenarios(actor Ahni)
    (OCR_CommitmentUtilQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
    if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
        (OCR_CommitmentUtilQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
        if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
            CheckAttractionAndSetStage(Ahni)
        Else
            BA_AhniDialogue_RomanceProgressionQST.Reset()
            BA_AhniDialogue_RomanceProgressionQST.SetStage(50) ; Normal love confession
            BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
            MiscUtil.PrintConsole("Ahni's Romance Progression: progression stage set to 50.")
            Alias_AhniRPSandbox.ForceRefTo(Ahni)
            BA_AhniDialogue_RomanceVariablesQST.Stop()
        endif
    Else
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires the player character to not be in an exclusive relationship to resume the romance progression.")
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function HandleUpsetScenarios(actor Ahni)
    float AhniAttraction = (OCR_AttractionUtilQST as OCR_AttractionUtil).CalculateNPCAttraction(Ahni)
    MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni's calculated attraction is" + AhniAttraction)
    float AhniIntimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if AhniAttraction >= 1.15 && AhniIntimacy >= 50
        (OCR_CommitmentUtilQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInExclusiveRelationship()
        if OCR_Commitment_PlayerIsInExclusiveRelationship.GetValue() == 0 ; Exclusive relationship check
            (OCR_CommitmentUtilQST as OCR_CommitmentUtil).UpdateGlobalVariable_PlayerIsInNonexclusiveRelationship()
            if OCR_Commitment_PlayerIsInNonexclusiveRelationship.GetValue() == 1  ; Nonexclusive relationship check
                BA_AhniDialogue_RomanceProgressionQST.Reset()
                BA_AhniDialogue_RomanceProgressionQST.SetStage(90)
                BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Ahni's Romance Progression: progression stage set to 90.")
                Alias_AhniRPSandbox.ForceRefTo(Ahni)
                BA_AhniDialogue_RomanceVariablesQST.Stop()
            Else
                BA_AhniDialogue_RomanceProgressionQST.Reset()
                BA_AhniDialogue_RomanceProgressionQST.SetStage(70)
                BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
                MiscUtil.PrintConsole("Ahni's Romance Progression: progression stage set to 70.")
                Alias_AhniRPSandbox.ForceRefTo(Ahni)
                BA_AhniDialogue_RomanceVariablesQST.Stop()
            endif
        Else
            BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
            MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires the player character to not be in an exclusive relationship to resume the progression.")
            BA_AhniDialogue_RomanceVariablesQST.Stop()
        endif
    ElseIf AhniAttraction < 1.15
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires the player character to be more attractive to resume the progression.")
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    Else
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires higher Intimacy to resume the progression.")
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    endif
endFunction

function CheckAttractionAndSetStage(actor Ahni)
    float AhniAttraction = (OCR_AttractionUtilQST as OCR_AttractionUtil).CalculateNPCAttraction(Ahni)
    MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni's calculated attraction is " + AhniAttraction)
    float AhniIntimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if AhniAttraction >= 1.0 && AhniIntimacy >= 50
        BA_AhniDialogue_RomanceProgressionQST.Reset()
        BA_AhniDialogue_RomanceProgressionQST.SetStage(80)
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(1)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Romance progression stage set to 80.")
        Alias_AhniRPSandbox.ForceRefTo(Ahni)
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    ElseIf AhniAttraction < 1.0
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires the player character to be more attractive to resume the progression.")
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    Else
        BA_AhniDialogue_RomanceProgression_ProgressionPossible.SetValue(0)
        MiscUtil.PrintConsole("Ahni's Romance Progression: Ahni requires higher Intimacy to resume the progression.")
        BA_AhniDialogue_RomanceVariablesQST.Stop()
    endif
endFunction