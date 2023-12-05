Scriptname BA_LocationChangeApproachCooldown extends ObjectReference  

GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property BA_CooldownToSet_FGUniversal  Auto  

Event OnLocationChange()
	if GameDaysPassed.getvalue() > BA_CooldownToSet_FGUniversal.getvalue()
		float currenttime = GameDaysPassed.getvalue()
		float r = Utility.RandomFloat(0, 0.007) ;10 minutes
		float setcooldown = currenttime + r
		BA_CooldownToSet_FGUniversal.setvalue(setcooldown)
		Debug.Notification("BA_LocationChangeApproachCooldown has fired.")
	endif
endEvent