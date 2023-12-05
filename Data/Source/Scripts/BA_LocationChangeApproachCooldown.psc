Scriptname BA_LocationChangeApproachCooldown extends ObjectReference  

Actor  Property playerref  Auto  
GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property BA_CooldownToSet_FGUniversal  Auto  
GlobalVariable Property BA_CooldownToSet_FG_Ready  Auto  

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if (playerref.GetCurrentLocation() != akOldLoc)
		Debug.Notification("BA_LocationChangeApproachCooldown: location has changed.")
			if GameDaysPassed.getvalue() > BA_CooldownToSet_FGUniversal.getvalue()
			float currenttime = GameDaysPassed.getvalue()
			float r = Utility.RandomFloat(0, 0.007) ;10 minutes
			float setcooldown = currenttime + r
			BA_CooldownToSet_FGUniversal.setvalue(setcooldown)
			Debug.Notification("BA_LocationChangeApproachCooldown: attempting to set cooldown.")
			BA_CooldownToSet_FG_Ready.setvalue(1)
		endif
	endif
endEvent