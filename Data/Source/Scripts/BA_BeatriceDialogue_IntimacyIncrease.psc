Scriptname BA_BeatriceDialogue_IntimacyIncrease extends Quest  

Actor Property myActor Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
OCR_OStimSequencesUtil Property Util Auto
SPELL Property BA_Buff_BeasInsight_Spell1  Auto
SPELL Property BA_Buff_BeasInsight_Spell2  Auto
SPELL Property BA_Buff_BeasInsight_Spell3  Auto
SPELL Property BA_Buff_BeasInsight_Spell4  Auto
SPELL Property BA_Buff_BeasInsight_Spell5  Auto

Function SpendTimeIntimacy()
    RegisterForModEvent("ostim_end", "OStimEnd")
    Util.ChatterNPC(myActor)
EndFunction

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    OCR_GlobalFunctions.AdvanceTimeByHours(2, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    int r = Utility.RandomInt(0, 100)
    if r < 41
        int currentrank = myActor.GetFactionRank(OCR_Lover_Value_Intimacy)
        int newrank = currentrank + 2
        myActor.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
        debug.notification("Intimacy with Beatrice has increased.")
        if currentrank < 10 && newrank >= 10
            debug.notification("Beatrice seems more open to you.")
        elseif currentrank < 20 && newrank >= 20
            debug.notification("You sense a stronger connection with Beatrice.")
        elseif currentrank < 30 && newrank >= 30
            debug.notification("Beatrice's affection toward you is more evident.")
        elseif currentrank < 40 && newrank >= 40
            debug.notification("There's a noticeable warmth in Beatrice's manner toward you.")
        elseif currentrank < 50 && newrank >= 50
            debug.notification("Beatrice's eyes reflect a deep affection toward you.")
        endif
    endif
    Debug.Notification("Spending time with Beatrice was insightful.")
    int Intimacy = myActor.GetFactionRank(OCR_Lover_Value_Intimacy)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell1)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell2)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell3)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell4)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell5)
    if Intimacy < 20
        BA_Buff_BeasInsight_Spell1.cast(playerRef, playerRef)
    elseif Intimacy < 40
        BA_Buff_BeasInsight_Spell2.cast(playerRef, playerRef)
    elseif Intimacy < 60
        BA_Buff_BeasInsight_Spell3.cast(playerRef, playerRef)
    elseif Intimacy < 80
        BA_Buff_BeasInsight_Spell4.cast(playerRef, playerRef)
    else ; This covers Intimacy > 80
        BA_Buff_BeasInsight_Spell5.cast(playerRef, playerRef)
    endif
    UnregisterForModEvent("ostim_end")
endEvent