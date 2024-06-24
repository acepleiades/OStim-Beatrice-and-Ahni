Scriptname BA_AhniDialogue_Lover extends Quest  

Actor Property PlayerREF Auto
GlobalVariable property BA_AhniDialogue_TalkedAcceptMultiplePartners auto
Quest Property OCR_OStimScenesUtilQST Auto
Quest Property OCR_OStimSequencesUtilQST Auto
Quest Property OCR_PrivateCellsUtilQST  Auto
Message Property BA_AhniDialogue_Sexual_FurnitureMSG Auto
Message Property BA_MSG_LoverRestricted_Gold Auto
Message Property BA_MSG_LoverRestricted_NoInn Auto
Message Property BA_MSG_LoverRestricted_PrivateLocation Auto


Function Flirt(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).Flirt(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Court(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CourtNPC(actor1)
    endif
endfunction

Function Caress(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).Caress(akspeaker)
    int r = Utility.RandomInt(0, 5)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressCheekStroke(actor1)
    ElseIf r == 1
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressCheekStrokeNPC(actor1)
    ElseIf r == 2
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHoldHands(actor1)
    ElseIf r == 3
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHoldHandsNPC(actor1)
    ElseIf r == 4
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHug(actor1)
    ElseIf r == 5
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHugNPC(actor1)
    endif
endfunction

Function Kiss(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).Kiss(akspeaker)
    int r = Utility.RandomInt(0, 1)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1(actor1)
    Else
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1NPC(actor1)
    endif
endfunction

function InnVisit(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).InnVisit(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).GoToPrivateCell_Inn(actor1)
endfunction

Function UnrestrictedActions(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).UnrestrictedActions(akspeaker)
    (OCR_OStimScenesUtilQST as OCR_OStimScenesUtil).OCR_StartScene(actor1)
endfunction

Function Pleasure_Mouth(actor actor1)
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).Pleasure_Mouth(akspeaker)
    Int iChoice = BA_AhniDialogue_Sexual_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = actor1
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, actor1)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("BA_AhniDialogue_Lover: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = actor1
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "blowjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, actor1)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_AhniDialogue_Lover: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_AhniDialogue_Lover: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = actor1
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="sitting")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, actor1)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_AhniDialogue_Lover: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_AhniDialogue_Lover: No suitable furniture was found.")
            return
        endif
    endIf
endFunction


function TalkedAcceptMultiplePartners()
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).TalkedAcceptMultiplePartners()
    BA_AhniDialogue_TalkedAcceptMultiplePartners.SetValue(1)
endfunction

;Notifications for the feature being restricted

function InnVisitRestricted_Gold()
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).InnVisitRestricted_Gold()
    BA_MSG_LoverRestricted_Gold.Show()
endfunction
function InnVisitRestricted_Location()
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).InnVisitRestricted_Location()
    BA_MSG_LoverRestricted_NoInn.Show()
endfunction
Function UnrestrictedActionsRestricted()
    ;(GetOwningQuest() as BA_AhniDialogue_Lover).UnrestrictedActionsRestricted()
    BA_MSG_LoverRestricted_PrivateLocation.Show()
endfunction