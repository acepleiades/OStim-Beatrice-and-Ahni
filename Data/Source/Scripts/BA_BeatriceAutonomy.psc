Scriptname BA_BeatriceAutonomy extends Quest  

Actor Property Beatrice  Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_AcceptsMultiplePartnersFaction  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
Faction Property OCR_OStimScenes_3PPCandidateFaction  Auto
GlobalVariable Property BA_BeatriceAutoFG_Ready  Auto
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
ReferenceAlias Property OCR_InvitedNPC_MyOwn  Auto
ReferenceAlias Property OCR_InvitedNPC_Original  Auto

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
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Refreshing autonomy.")
    BA_BeatriceAutoFG_Ready.setvalue(0)
    AutonomousInteraction()
    ;For OCR private cells, prevents further refreshing when autonomous actions are not possible.
    actor OCR_InvitedNPC = OCR_InvitedNPC_Original.GetActorReference()
    OCR_InvitedNPC_MyOwn.ForceRefTo(OCR_InvitedNPC)
endfunction

function ClearMyOCRInvitedNPCAlias()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).ClearMyOCRInvitedNPCAlias()
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Clearing my OCR_InvitedNPC Alias.")
    OCR_InvitedNPC_MyOwn.Clear()
endfunction

; Type 1: Hang out

Function HangOut_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).HangOut_SetReady()
    ClearFGAliases()
    Utility.Wait(0.1)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG1_HangOut.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 2: Caress

Function Caress_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Caress_SetReady()
    ClearFGAliases()
    Utility.Wait(0.1)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG2_Caress.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 3: Kiss

Function Kiss_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Kiss_SetReady()
    ClearFGAliases()
    Utility.Wait(0.1)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG3_Kiss.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 4: Private room

Function PrivateRoom_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).PrivateRoom_SetReady()
    ClearFGAliases()
    Utility.Wait(0.1)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG4_PrivateRoom.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Type 5: Sexual intercourse

Function SexualIntercourse_SetReady()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SexualIntercourse_SetReady()
    ClearFGAliases()
    Utility.Wait(0.1)
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Forcing Beatrice into alias and re-evaluating package.")
    BeatriceAutoFG5_Sexual.ForceRefTo(Beatrice)
    BA_BeatriceAutoFG_Ready.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

; Function for clearing all FG aliases

Function ClearFGAliases()
    MiscUtil.PrintConsole("BA_BeatriceAutonomy: Clearing aliases.")
    BeatriceAutoFG1_HangOut.Clear()
    BeatriceAutoFG2_Caress.Clear()
    BeatriceAutoFG3_Kiss.Clear()
    BeatriceAutoFG4_FollowUp.Clear()
    BeatriceAutoFG4_PrivateRoom.Clear()
    BeatriceAutoFG5_Sexual.Clear()
    OCR_InvitedNPC_MyOwn.Clear()
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
    BeatriceAutoFG4_PrivateRoom.Clear()
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).GoToPrivateCell_Inn(Beatrice)
    BeatriceAutoFG4_FollowUp.ForceRefTo(Beatrice)
    Beatrice.EvaluatePackage()
endfunction

Function Autonomous_UnrestrictedActions()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_UnrestrictedActions()
    (OCR_OStimScenesUtilQST as OCR_OStimScenesUtil).OCR_StartScene(Beatrice)
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_HandRelief()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_HandRelief()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(Actors, AnyActionType="handjob", AnyActorTagForAny="standing")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.NoFurniture(BuilderID)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(Actors, "chair", "handjob")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, chair)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(Actors, AnyActionType="handjob", AnyActorTagForAny="lyingback")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, bed)
        int threadID = OThreadBuilder.Start(BuilderID)
    endIf
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_Fellatio()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_Fellatio()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(Actors, AnyActionType="blowjob", AnyActorTagForAny="standing")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.NoFurniture(BuilderID)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(Actors, "chair", "blowjob")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, chair)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(Actors, AnyActionType="blowjob", AnyActorTagForAny="lyingback")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, bed)
        int threadID = OThreadBuilder.Start(BuilderID)
    endIf
    RegisterForModEvent("ostim_end", "OStimEnd")
endfunction

Function Autonomous_Sexual_MountedSex()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).Autonomous_Sexual_MountedSex()
    SetCooldownAccepted_Sexual()
    Int iChoice = BA_BeatriceAutoFG_FurnitureMSG.Show()
    if iChoice == 0 ; On the floor
        string sceneID = OLibrary.GetRandomSceneWithSceneTag(Actors, "cowgirl")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.NoFurniture(BuilderID)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(Actors, "chair", "vaginalsex")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, chair)
        int threadID = OThreadBuilder.Start(BuilderID)
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        string sceneID = OLibrary.GetRandomSceneWithSceneTag(Actors, "cowgirl")
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actors = OActorUtil.ToArray(playerref, Beatrice)
        int BuilderID = OThreadBuilder.Create(actors)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.SetFurniture(BuilderID, bed)
        int threadID = OThreadBuilder.Start(BuilderID)
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
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 1 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomyNonsexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownRefused_Nonsexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownRefused_Nonsexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 3 + r
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
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 1 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaAutonomySexual.setvalue(setcooldown)
    BA_BeatriceAutoFG_Ready.setvalue(0)
    ClearFGAliases()
EndFunction

Function SetCooldownRefused_Sexual()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownRefused_Sexual()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 3 + r
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