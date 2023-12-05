Scriptname CooldownToSet_AhniFGTalk extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_AhniFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready  Auto  

Function SetApproachReady()
	BA_CooldownToSet_FG_Ready.setvalue(1)
EndFunction


Function SetCooldown()
	float currenttime = GameDaysPassed.getvalue()
	float r = Utility.RandomFloat(0, 0.25)
	float cooldown = 1 + r
	float setcooldown = currenttime + cooldown
	
	BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)
	BA_CooldownToSet_FG_Ready.setvalue(0)

	float cooldownuniversal = Utility.RandomFloat(0, 0.083);2 hours
	float setcooldownuniversal = currenttime + cooldownuniversal

	BA_CooldownToSet_FGUniversal.setvalue(setcooldown)
EndFunction


Function SetCooldownRefused()
	;If the player refuses the interaction, the cooldown is between 72 to 84 in-game hours

	float currenttimeRefused = GameDaysPassed.getvalue()
	float rRefused = Utility.RandomFloat(0, 0.25)
	float cooldownRefused = 3 + rRefused
	float setcooldownRefused = currenttimeRefused + cooldownRefused

	BA_CooldownToSet_AhniFGTalk.setvalue(setcooldownRefused)
EndFunction