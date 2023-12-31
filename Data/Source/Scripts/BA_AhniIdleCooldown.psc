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
	if r < 34
		int currentrank = myActor.GetFactionRank(OCR_Lover_Value_Intimacy)
		int newrank = currentrank + 2
		myActor.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
		debug.notification("Intimacy with Ahni  has increased.")
	endif
EndFunction