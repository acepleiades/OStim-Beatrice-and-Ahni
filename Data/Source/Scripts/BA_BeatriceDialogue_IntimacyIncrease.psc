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