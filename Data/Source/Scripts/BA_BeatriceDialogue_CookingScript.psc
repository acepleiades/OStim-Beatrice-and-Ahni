Scriptname BA_BeatriceDialogue_CookingScript extends Quest  

Actor Property PlayerREF Auto
Actor Property Beatrice Auto
GlobalVariable Property BA_CooldownToSet_BeatriceCooking  Auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
ImageSpaceModifier Property FadeToBlackBackImod Auto
ImageSpaceModifier Property FadeToBlackImod Auto
Potion Property FoodAppleCabbageStew  Auto
Potion Property FoodBeefStew  Auto
Potion Property FoodHorkerStew  Auto
Potion Property FoodVenisonStew  Auto
Quest Property BA_BeatriceDialogue_Cooking  Auto
ReferenceAlias Property Alias_BeatriceCookingIntro  Auto
Faction Property OCR_Lover_PlayerCommittedRelationshipFaction  Auto

function CookingIntro_Function1()
    ;(GetOwningQuest() as BA_BeatriceDialogue_CookingScript).CookingIntro_Function1()
    Utility.Wait(3)
    AdvanceTimeAndFade(1)
endfunction

function CookingIntro_Function2()
    ;(GetOwningQuest() as BA_BeatriceDialogue_CookingScript).CookingIntro_Function2()
    PlayerREF.AddItem(FoodAppleCabbageStew)
    BA_BeatriceDialogue_Cooking.SetStage(10)
    Alias_BeatriceCookingIntro.Clear()
endfunction

function CookingIntro_Refuse()
    ;(GetOwningQuest() as BA_BeatriceDialogue_CookingScript).CookingIntro_Refuse()
    BA_BeatriceDialogue_Cooking.SetStage(10)
    Alias_BeatriceCookingIntro.Clear()
endfunction

Function Cooking()
    if Beatrice.IsInFaction(OCR_Lover_PlayerCommittedRelationshipFaction)
        Actor[] actors = new actor[2]
        Actors[0] = PlayerREF
        Actors[1] = Beatrice
        string cookingpotscene = OLibrary.GetRandomFurnitureSceneWithSceneTag(Actors, "cookingpot", "cuddling")
        if cookingpotscene != ""
            ObjectReference cookingpot = OFurniture.FindFurnitureOfType("cookingpot", PlayerRef, 10000, 1000)
            StartCookingTogetherScene(PlayerREF, Beatrice, cookingpot, cookingpotscene)
        Else
            Debug.Notification("Install OARE to cook together with Beatrice.")
        endif
    Else
        AdvanceTimeAndFade(1)
        AddRandomStewToPlayer()
    EndIf
    SetCooldown()
EndFunction

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

Function AdvanceTimeAndFade(Float hours)
    FadeToBlackImod.Apply()
    Utility.Wait(2)
    OCR_GlobalFunctions.AdvanceTimeByHours(hours, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    FadeToBlackBackImod.Apply()
    FadeToBlackImod.Remove()
EndFunction

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

Function SetCooldown()
    float currenttime = GameDaysPassed.GetValue()
    float setcooldown = currenttime + 0.5
    BA_CooldownToSet_BeatriceCooking.SetValue(setcooldown)
EndFunction