Scriptname BA_AhniIdleCooldown extends Quest  

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property BA_Cooldown_IdleDialogue  Auto
GlobalVariable Property BA_CooldownToSet_AhniIdle  Auto
GlobalVariable Property BA_CooldownToSet_AhniIdle_Daily  Auto
Actor Property Ahni Auto
Faction Property OCR_Lover_Value_Intimacy  Auto

Function SetIdleCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + BA_Cooldown_IdleDialogue.getvalue()
    BA_CooldownToSet_AhniIdle.setvalue(setcooldown)
EndFunction

Function SetDailyIdleCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown1 = currenttime + 1.5
    BA_CooldownToSet_AhniIdle_Daily.setvalue(setcooldown1)
EndFunction

Function IncreaseIntimacy()
    int Intimacy = Ahni.GetFactionRank(OCR_Lover_Value_Intimacy)
    if Intimacy < 100
        int newIntimacy = Intimacy + 1
        Ahni.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        MiscUtil.PrintConsole("Ahni's Intimacy value was " + Intimacy + " and is now " + newIntimacy)
        debug.notification("Intimacy with Ahni has increased.")
        if Intimacy < 10 && newIntimacy >= 10
            debug.notification("You may progress your relationship with Ahni at a private location.")
        elseif Intimacy < 20 && newIntimacy >= 20
            debug.notification("You may progress your relationship with Ahni at a private location.")
        elseif Intimacy < 30 && newIntimacy >= 30
            debug.notification("You may progress your relationship with Ahni at a private location.")
        elseif Intimacy < 40 && newIntimacy >= 40
            debug.notification("You may progress your relationship with Ahni at a private location.")
        elseif Intimacy < 50 && newIntimacy >= 50
            debug.notification("You may progress your relationship with Ahni at a private location.")
        endif
    endif
    ;Ensure maximum intimacy is 100
    if Intimacy > 100
        Ahni.SetFactionRank(OCR_Lover_Value_Intimacy, 100)
    endif
EndFunction