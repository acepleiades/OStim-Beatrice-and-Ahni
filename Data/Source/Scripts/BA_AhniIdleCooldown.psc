Scriptname BA_AhniIdleCooldown extends Quest  

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property BA_Cooldown_IdleDialogue  Auto
GlobalVariable Property BA_CooldownToSet_AhniIdle  Auto
GlobalVariable Property BA_CooldownToSet_AhniIdle_Daily  Auto
Actor Property myActor Auto
Faction Property OCR_Lover_Value_Intimacy  Auto

Function SetIdleCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + BA_Cooldown_IdleDialogue.getvalue()
    BA_CooldownToSet_AhniIdle.setvalue(setcooldown)
EndFunction

Function SetDailyIdleCooldown()
    float currenttime1 = GameDaysPassed.getvalue()
    float setcooldown1 = currenttime1 + 1.5
    BA_CooldownToSet_AhniIdle_Daily.setvalue(setcooldown1)
EndFunction

Function IncreaseIntimacy()
    int r = Utility.RandomInt(0, 100)
    int currentrank = myActor.GetFactionRank(OCR_Lover_Value_Intimacy)
    int newrank = currentrank + 1
    myActor.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
    MiscUtil.PrintConsole("Ahni's Intimacy value was " + currentrank + " and is now " + newrank)
    debug.notification("Intimacy with Ahni  has increased.")
    if currentrank < 10 && newrank >= 10
        debug.notification("Ahni seems more open to you.")
    elseif currentrank < 20 && newrank >= 20
        debug.notification("You sense a stronger connection with Ahni.")
    elseif currentrank < 30 && newrank >= 30
        debug.notification("Ahni's affection toward you is more evident.")
    elseif currentrank < 40 && newrank >= 40
        debug.notification("There's a noticeable warmth in Ahni's manner toward you.")
    elseif currentrank < 50 && newrank >= 50
        debug.notification("Ahni's eyes reflect a deep affection toward you.")
    endif
EndFunction