Scriptname BA_BeatriceDialogueGeneral extends Quest  

Actor Property Beatrice Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable Property BA_CooldownToSet_BeaTalkRandom  Auto
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
Quest Property OCR_PrivateCellsUtilQST Auto

Function HangOut(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).HangOut(akspeaker)
    RegisterForModEvent("ostim_end", "OStimEnd")
    Util.ChatterNPC(Beatrice)
EndFunction

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    OCR_GlobalFunctions.AdvanceTimeByHours(2, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.25 ;6 hours
    BA_CooldownToSet_BeaTalkRandom.setvalue(setcooldown)
    int currentrank = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentrank < 100
        int newrank = currentrank + 2
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
        MiscUtil.PrintConsole("Beatrice's Intimacy value was " + currentrank + " and is now " + newrank)
        debug.notification("Intimacy with Beatrice has increased.")
        if currentrank < 10 && newrank >= 10
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif currentrank < 20 && newrank >= 20
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif currentrank < 30 && newrank >= 30
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif currentrank < 40 && newrank >= 40
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif currentrank < 50 && newrank >= 50
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        endif
    endif
    Debug.Notification("Spending time with Beatrice was insightful.")
    int Intimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
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
EndEvent

function Camp(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).Camp(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).FollowerCamping(actor1)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction