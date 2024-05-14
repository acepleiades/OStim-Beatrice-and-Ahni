Scriptname BA_BeatriceAutonomy extends Quest  

Actor Property Beatrice  Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property BA_BeatriceAutoFG_Ready  Auto
GlobalVariable Property BA_Cooldown_BeatriceAutoFG_Nonsexual  Auto
GlobalVariable Property BA_Cooldown_BeatriceAutoFG_Sexual  Auto
GlobalVariable Property BA_CooldownToSet_BeaAutonomyNonsexual  auto
GlobalVariable Property BA_CooldownToSet_BeaAutonomySexual  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
Keyword Property LocTypeCity Auto
Keyword Property LocTypeInn Auto
Keyword Property LocTypePlayerHouse Auto
Keyword Property LocTypeTown Auto
Keyword Property OCR_PrivateCell Auto
Message Property BA_BeatriceAutoFG_FurnitureMSG Auto
MiscObject Property Gold001  Auto
ObjectReference Property BA_XMarkerReset  Auto
Quest Property OCR_OStimScenesUtilQST Auto
Quest Property OCR_OStimSequencesUtilQST Auto
Quest Property OCR_PrivateCellsUtilQST  Auto
ReferenceAlias Property BeatriceAutoFG1_HangOut  Auto
ReferenceAlias Property BeatriceAutoFG2_Caress  Auto
ReferenceAlias Property BeatriceAutoFG3_Kiss  Auto
ReferenceAlias Property BeatriceAutoFG4_FollowUp  Auto
ReferenceAlias Property BeatriceAutoFG4_PrivateRoom  Auto
ReferenceAlias Property BeatriceAutoFG5_Sexual  Auto
ReferenceAlias Property OCR_InvitedNPC  Auto

Function AutonomousInteraction()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).AutonomousInteraction()
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous interaction.")
    float currentTime = GameDaysPassed.getvalue()
    if Beatrice.IsInFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
        MiscUtil.PrintConsole("BA_BeatriceAutonomy: Beatrice is lover. Lover autonomy is possible.")
        bool locationIsPrivate = 0
        form beatriceLocation = Beatrice.GetCurrentLocation() as form
        if beatriceLocation.HasKeyword(LocTypePlayerHouse) == 1 || beatriceLocation.HasKeyword(OCR_PrivateCell)  == 1
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Location is private.")
            locationIsPrivate = 1
        Else
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Location is not private.")
        endif
        bool wantsSexual = 0
        if currenttime > BA_CooldownToSet_BeaAutonomySexual.GetValue()
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Beatrice wants to have sexual intercourse.")
            wantsSexual = 1
        Else
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Beatrice does not want to have sexual intercourse.")
        endif
        bool locationHasInn = 0
        if beatriceLocation.HasKeyword(LocTypeCity) == 1 || beatriceLocation.HasKeyword(LocTypeTown)  == 1 || beatriceLocation.HasKeyword(LocTypePlayerHouse)  == 1 || beatriceLocation.HasKeyword(LocTypeInn)  == 1
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Current location has an inn.")
            locationHasInn = 1
        Else
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Current location does not have an inn.")
        endif
        ;Checks
        if locationIsPrivate == 1
            ;In private space
            if wantsSexual == 1
                MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Sexual Intercourse.")
                SexualIntercourse_SetReady()
            else
                int r = Utility.RandomInt(1, 3)
                if r == 1
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Hang Out.")
                    HangOut_SetReady()
                ElseIf r == 2
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Caress.")
                    Caress_SetReady()
                Else ; r == 3
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Kiss.")
                    Kiss_SetReady()
                EndIf
            endif
        Else
            ;In public space
            if wantsSexual == 1 && locationHasInn == 1
                MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Private Inn Room.")
                PrivateRoom_SetReady()
            else
                int r = Utility.RandomInt(1, 3)
                if r == 1
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Hang Out.")
                    HangOut_SetReady()
                ElseIf r == 2
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Caress.")
                    Caress_SetReady()
                Else ; r == 3
                    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Kiss.")
                    Kiss_SetReady()
                EndIf
            endif
        Endif
    Else
        MiscUtil.PrintConsole("BA_BeatriceAutonomy: Beatrice is not lover. Lover autonomy is not possible.")
        BA_CooldownToSet_BeaAutonomySexual.SetValue(BA_CooldownToSet_BeaAutonomyNonsexual.GetValue())
        if currentTime > BA_CooldownToSet_BeaAutonomyNonsexual.GetValue() 
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Hang Out.")
            HangOut_SetReady()
        else
            MiscUtil.PrintConsole("BA_BeatriceAutonomy: Nonsexual autonomy is still is cooldown.")
        endif
    endif
endFunction

function AutonomousInteractionRefresh()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).AutonomousInteractionRefresh()
    ;This function exists to prevent the autonomy AI package from not being applied last, which could cause it to become stuck.
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Refreshing autonomy.")
    BA_BeatriceAutoFG_Ready.setvalue(0)
    AutonomousInteraction()
endfunction

function Debug_ForceAutonomousInteraction()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Debug_ForceAutonomousInteraction()
    Utility.Wait(2)
    Debug.Notification("BA_BeatriceAutonomy: Forcing autonomous interaction.")
    BA_CooldownToSet_BeaAutonomyNonsexual.SetValue(0)
    BA_CooldownToSet_BeaAutonomySexual.SetValue(0)
    BA_CooldownToSet_FGUniversal.SetValue(0)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    AutonomousInteraction()
endfunction

; Type 1: Hang out

Function HangOut_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).HangOut_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into Alias and re-evaluating package.")
    BeatriceAutoFG1_HangOut.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 2: Caress

Function Caress_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Caress_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG2_Caress.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 3: Kiss

Function Kiss_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Kiss_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG3_Kiss.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 4: Private room

Function PrivateRoom_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).PrivateRoom_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG4_PrivateRoom.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

Function PrivateRoomFollowUp_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).PrivateRoomFollowUp_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG4_FollowUp.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction


; Type 5: Sexual intercourse

Function SexualIntercourse_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SexualIntercourse_SetReady()
    ClearFGAliases()
    OCR_InvitedNPC_ClearAlias()
    ;Add to ForceGreet Alias
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG5_Sexual.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Helper functions

Function ClearFGAliases()
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Clearing aliases.")
    BeatriceAutoFG1_HangOut.Clear()
    BeatriceAutoFG2_Caress.Clear()
    BeatriceAutoFG3_Kiss.Clear()
    BeatriceAutoFG4_FollowUp.Clear()
    BeatriceAutoFG4_PrivateRoom.Clear()
    BeatriceAutoFG5_Sexual.Clear()
endFunction

Function OCR_InvitedNPC_ClearAlias()
    actor OCR_InvitedNPC_Original = OCR_InvitedNPC.GetActorReference()
    if OCR_InvitedNPC_Original == Beatrice
        MiscUtil.PrintConsole("BA_BeatriceAutonomy: Beatrice was the first NPC to be invited into a private cell. That Alias needs to be cleared.")
        OCR_InvitedNPC.Clear()
    endif
endFunction

; Results for the invitation being accepted

Function Autonomous_Flirt()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Flirt()
    SetCooldownAccepted_Nonsexual()
    RegisterForModEvent("ostim_end", "OStimEnd")
    (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CourtNPC(Beatrice)
endfunction

Function Autonomous_Caress()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Caress()
    SetCooldownAccepted_Nonsexual()
    int r = Utility.RandomInt(0, 2)
    if r == 0
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressCheekStrokeNPC(Beatrice)
    ElseIf r == 1
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHoldHandsNPC(Beatrice)
    ElseIf r == 2
        (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).CaressHugNPC(Beatrice)
    endif
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Kiss()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Kiss()
    SetCooldownAccepted_Nonsexual()
    (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).Kiss1NPC(Beatrice)
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

function Autonomous_InnVisit()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_InnVisit()
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting inn room visit.")
    PlayerRef.AddItem(Gold001, 50)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).GoToPrivateCell_Inn(Beatrice)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Starting autonomous action Private Room Follow Up.")
    Utility.Wait(1.5)
    PrivateRoomFollowUp_SetReady()
endfunction

Function Autonomous_UnrestrictedActions()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_UnrestrictedActions()
    SetCooldownAccepted_Sexual()
    (OCR_OStimScenesUtilQST as OCR_OStimScenesUtil).OCR_StartScene(Beatrice)
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_HandRelief()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_HandRelief()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = Beatrice
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="handjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "handjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="handjob", AnyActorTagForAny="lyingback")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    endIf
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_Fellatio()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_Fellatio()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = Beatrice
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "blowjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="sitting")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    endIf
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_MountedSex()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_Fellatio()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = Beatrice
        string sceneID = OLibrary.GetRandomSceneWithSceneTag(sceneActors, "cowgirl")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "vaginalsex")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = Beatrice
            string sceneID = OLibrary.GetRandomSceneWithSceneTag(sceneActors, "cowgirl")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, Beatrice)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("BA_BeatriceAutonomy: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("BA_BeatriceAutonomy: No suitable furniture was found.")
            return
        endif
    endIf
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

; Cooldown management

Function SetCooldownWA_Nonsexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownWA_Nonsexual()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0416
    BA_CooldownToSet_BeaAutonomyNonsexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownWA_Sexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownWA_Sexual()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0416
    BA_CooldownToSet_BeaAutonomySexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownAccepted_Nonsexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownAccepted_Nonsexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.0830)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.0625)
    float cooldown = BA_Cooldown_BeatriceAutoFG_Nonsexual.GetValue() + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomyNonsexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownRefused_Nonsexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownRefused_Nonsexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.0830)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = (BA_Cooldown_BeatriceAutoFG_Nonsexual.GetValue() * 3) + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomyNonsexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction


Function SetCooldownAccepted_Sexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownAccepted_Sexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.0625)
    float cooldown = BA_Cooldown_BeatriceAutoFG_Sexual.GetValue() + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomySexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownRefused_Sexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownRefused_Sexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.0830)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.0625)
    float cooldown = (BA_Cooldown_BeatriceAutoFG_Sexual.GetValue() * 3) + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomySexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

; Gameplay effect

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    UnregisterForModEvent("ostim_end")
    ;Initialize Intimacy
    int Intimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    ;Reset actor
    BA_XMarkerReset.MoveTo(Beatrice)
    Beatrice.Reset()
    Beatrice.MoveTo(BA_XMarkerReset)
    BA_XMarkerReset.Reset()
    ;Time skip
    OCR_GlobalFunctions.AdvanceTimeByHours(0.5, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    ;Intimacy increase
    if Intimacy < 100
        int newIntimacy = Intimacy + 2
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        MiscUtil.PrintConsole("Beatrice's Intimacy value was " + Intimacy + " and is now " + newIntimacy)
        debug.notification("Intimacy with Beatrice has increased.")
    endif
    ;Ensure maximum intimacy is 100
    if Intimacy > 100
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, 100)
    endif
EndEvent