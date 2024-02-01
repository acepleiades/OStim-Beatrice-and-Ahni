Scriptname BA_BeaIdleCooldown extends Quest  

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property BA_Cooldown_IdleDialogue  Auto
GlobalVariable Property BA_CooldownToSet_BeaIdle  Auto
Actor Property myActor Auto
Faction Property OCR_Lover_Value_Intimacy  Auto

Function SetIdleCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + BA_Cooldown_IdleDialogue.getvalue()
    BA_CooldownToSet_BeaIdle.setvalue(setcooldown)
EndFunction

Function IncreaseIntimacy()
    int currentrank = myActor.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentrank < 100
        int newrank = currentrank + 2
        myActor.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
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
EndFunction