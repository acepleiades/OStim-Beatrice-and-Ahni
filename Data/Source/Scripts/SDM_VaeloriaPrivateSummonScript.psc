Scriptname SDM_VaeloriaPrivateSummonScript extends Quest  

Actor Property PlayerREF Auto
Actor Property SDM_Vaeloria Auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownCooking auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownPrivateSummon auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownStudy auto
Idle Property IdleBook_TurnManyPages Auto
ImageSpaceModifier Property FadeToBlackBackImod Auto
ImageSpaceModifier Property FadeToBlackImod Auto
Message Property SDM_VaeloriaDialogue_PS_FurnitureMSG Auto
Potion Property FoodAppleCabbageStew  Auto
Potion Property FoodBeefStew  Auto
Potion Property FoodHorkerStew  Auto
Potion Property FoodVenisonStew  Auto
Quest Property SDM_VaeloriaDialogue_PrivateSummon  Auto

Function StartFG()
    SDM_Vaeloria.EvaluatePackage()
EndFunction

;Please stand by.
Function EndQuest()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).EndQuest()
    SetCooldown_PrivateSummon()
    SDM_VaeloriaDialogue_PrivateSummon.Stop()
    SDM_Vaeloria.EvaluatePackage()
EndFunction

Function SetCooldown_PrivateSummon()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0416
    SDM_VaeloriaDialogue_CooldownPrivateSummon.setvalue(setcooldown)
EndFunction

;Would you cook something for me?
Function Cooking()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Cooking()
    SetCooldown_Cooking()
    Actor[] actors = new actor[2]
    Actors[0] = PlayerREF
    Actors[1] = SDM_Vaeloria
    string cookingpotscene = OLibrary.GetRandomFurnitureSceneWithSceneTag(Actors, "cookingpot", "cuddling")
    if cookingpotscene != ""
        ObjectReference cookingpot = OFurniture.FindFurnitureOfType("cookingpot", PlayerRef, 10000, 1000)
        if cookingpot != ""
            StartCookingTogetherScene(PlayerREF, SDM_Vaeloria, cookingpot, cookingpotscene)
        Else
            Debug.Notification("No cooking pot found.")
        endif
    Else
        Debug.Notification("Install OARE to cook together with Vaeloria.")
    endif
endFunction

Function StartCookingTogetherScene(Actor actor1, Actor actor2, ObjectReference cookingpot, string sceneID)
    RegisterForModEvent("ostim_end", "OStimEnd")
    OsexIntegrationMain ostim = OUtils.GetOStim()
    Actor[] actors = OActorUtil.ToArray(actor1, actor2)
    int BuilderID = OThreadBuilder.Create(actors)
    OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
    OThreadBuilder.SetFurniture(BuilderID, cookingpot)
    int threadID = OThreadBuilder.Start(BuilderID)
EndFunction

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    UnregisterForModEvent("ostim_end")
    AddRandomStewToPlayer()
EndEvent

Function AddRandomStewToPlayer()
    int r = Utility.RandomInt(1, 4)
    if r == 1
        PlayerREF.AddItem(FoodAppleCabbageStew, 1)
    ElseIf r == 2
        PlayerREF.AddItem(FoodBeefStew, 1)
    ElseIf r == 3
        PlayerREF.AddItem(FoodHorkerStew, 1)
    Else ; r == 4
        PlayerREF.AddItem(FoodVenisonStew, 1)
    EndIf
EndFunction

Function SetCooldown_Cooking()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).SetCooldown_Cooking()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    SDM_VaeloriaDialogue_CooldownCooking.setvalue(setcooldown)
EndFunction

;I'd like your help in studying Illusion magic.
Function StudyIllusionIdle()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).StudyIllusionIdle()
    SDM_Vaeloria.PlayIdle(IdleBook_TurnManyPages)
EndFunction

Function StudyIllusion()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).StudyIllusion()
    SetCooldown_StudyIllusion()
    AdvanceTimeAndFade(2)
    int playerLevel = PlayerREF.GetLevel()
    float xpGain = CalculateXPGain(playerLevel)
    Game.AdvanceSkill("Illusion", xpGain)
endFunction

float function CalculateXPGain(int playerLevel)
    float baseXP = 500.0
    float scalingFactor = 1.5
    float xpGain = baseXP + (scalingFactor * playerLevel) * (1 + 0.01 * playerLevel)
    return xpGain
endfunction

Function AdvanceTimeAndFade(Float hours)
    FadeToBlackImod.Apply()
    Utility.Wait(2)
    OCR_GlobalFunctions.AdvanceTimeByHours(hours, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    FadeToBlackBackImod.Apply()
    FadeToBlackImod.Remove()
EndFunction

Function SetCooldown_StudyIllusion()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).SetCooldown_StudyIllusion()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    SDM_VaeloriaDialogue_CooldownStudy.setvalue(setcooldown)
EndFunction

;Remind me of the taste of your lips.
Function Kiss()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Kiss()
    Actor[] sceneActors = new actor[2]
    sceneActors[0] = playerref
    sceneActors[1] = SDM_Vaeloria
    string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="kissing", AnyActorTagForAny="standing", ActionBlacklistTypes="sexual")
    if sceneID != ""
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
        int BuilderID = OThreadBuilder.Create(actorArrayForThread)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.NoFurniture(BuilderID)
        int threadID = OThreadBuilder.Start(BuilderID)
    Else
        Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
    endif
endFunction

;Pleasure me with your hands.
Function Pleasure_Hands()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_Hands()
    Int iChoice = SDM_VaeloriaDialogue_PS_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = SDM_Vaeloria
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="handjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "handjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="handjob", AnyActorTagForAny="lyingback")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    endIf
endFunction

;Pleasure me with your mouth.
Function Pleasure_Mouth()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_Mouth()
    Int iChoice = SDM_VaeloriaDialogue_PS_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = SDM_Vaeloria
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "blowjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="blowjob", AnyActorTagForAny="sitting")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    endIf
endFunction

;Pleasure me with your breasts.
Function Pleasure_Breasts()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_Breasts()
    Int iChoice = SDM_VaeloriaDialogue_PS_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = SDM_Vaeloria
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="boobjob", AnyActorTagForAny="standing")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "boobjob")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActionType="boobjob", AnyActorTagForAny="sitting,lyingback")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    endIf
endFunction

;(Feel Vaeloria up.)
Function Pleasure_FeelUp()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_FeelUp()
    Actor[] sceneActors = new actor[2]
    sceneActors[0] = playerref
    sceneActors[1] = SDM_Vaeloria
    string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActorTagForAny="standing", AnyActionType="gropingbreast,gropingbutt,rubbingclitoris,vaginalfingering", AnyActionActor="playerref")
    if sceneID != ""
        OsexIntegrationMain ostim = OUtils.GetOStim()
        Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
        int BuilderID = OThreadBuilder.Create(actorArrayForThread)
        OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
        OThreadBuilder.NoFurniture(BuilderID)
        int threadID = OThreadBuilder.Start(BuilderID)
    Else
        Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
    endif
endFunction

;Take me inside of you.
Function Pleasure_SexAsBottom()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_SexAsBottom()
    Int iChoice = SDM_VaeloriaDialogue_PS_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = SDM_Vaeloria
        string sceneID = OLibrary.GetRandomSceneWithSceneTag(sceneActors, "cowgirl")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "vaginalsex")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomSceneWithSceneTag(sceneActors, "cowgirl")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    endIf
endFunction

;Give yourself to me, Vaeloria.
Function Pleasure_SexAsTop()
    ;(GetOwningQuest() as SDM_VaeloriaPrivateSummonScript).Pleasure_SexAsTop()
    Int iChoice = SDM_VaeloriaDialogue_PS_FurnitureMSG.Show()
    if iChoice == 0 ; Standing
        Actor[] sceneActors = new actor[2]
        sceneActors[0] = playerref
        sceneActors[1] = SDM_Vaeloria
        string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActorTagForAny="standing", AnyActionType="vaginalsex", AnyActionActor="playerref")
        if sceneID != ""
            OsexIntegrationMain ostim = OUtils.GetOStim()
            Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
            int BuilderID = OThreadBuilder.Create(actorArrayForThread)
            OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
            OThreadBuilder.NoFurniture(BuilderID)
            int threadID = OThreadBuilder.Start(BuilderID)
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
            return
        endif
    elseif iChoice == 1 ; Chair
        ObjectReference chair = OFurniture.FindFurnitureOfType("chair", PlayerRef, 10000, 1000)
        if chair != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomFurnitureSceneWithAction(sceneActors, "chair", "vaginalsex")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, chair)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    elseif iChoice == 2 ; Bed
        ObjectReference bed = OFurniture.FindFurnitureOfType("bed", PlayerRef, 10000, 1000)
        if bed != None
            Actor[] sceneActors = new actor[2]
            sceneActors[0] = playerref
            sceneActors[1] = SDM_Vaeloria
            string sceneID = OLibrary.GetRandomSceneSuperloadCSV(sceneActors, AnyActorTagForAny="kneeling", AnyActionType="vaginalsex", AnyActionActor="playerref")
            if sceneID != ""
                OsexIntegrationMain ostim = OUtils.GetOStim()
                Actor[] actorArrayForThread = OActorUtil.ToArray(playerref, SDM_Vaeloria)
                int BuilderID = OThreadBuilder.Create(actorArrayForThread)
                OThreadBuilder.SetStartingAnimation(BuilderID, sceneID)
                OThreadBuilder.SetFurniture(BuilderID, bed)
                int threadID = OThreadBuilder.Start(BuilderID)
            Else
                Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable OStim scene was found.")
                return
            endif
        Else
            Debug.Notification("SDM_VaeloriaPrivateSummonScript: No suitable furniture was found.")
            return
        endif
    endIf
endFunction