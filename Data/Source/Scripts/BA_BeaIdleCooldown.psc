Scriptname BA_BeaIdleCooldown extends Quest  

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property BA_Cooldown_IdleDialogue  Auto
GlobalVariable Property BA_CooldownToSet_BeaIdle  Auto
Actor Property Beatrice Auto
Faction Property OCR_Lover_Value_Intimacy  Auto

Function SetIdleCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + BA_Cooldown_IdleDialogue.getvalue()
    BA_CooldownToSet_BeaIdle.setvalue(setcooldown)
EndFunction

Function IncreaseIntimacy()
    int Intimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    if Intimacy < 100
        int newIntimacy = Intimacy + 1
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        MiscUtil.PrintConsole("Beatrice's Intimacy value was " + Intimacy + " and is now " + newIntimacy)
        debug.notification("Intimacy with Beatrice has increased.")
        if Intimacy < 10 && newIntimacy >= 10
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 20 && newIntimacy >= 20
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 30 && newIntimacy >= 30
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 40 && newIntimacy >= 40
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 50 && newIntimacy >= 50
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        endif
    endif
    ;Ensure maximum intimacy is 100
    if Intimacy > 100
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, 100)
    endif
EndFunction