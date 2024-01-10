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
	int r = Utility.RandomInt(0, 100)
	if r < 34
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
EndFunction