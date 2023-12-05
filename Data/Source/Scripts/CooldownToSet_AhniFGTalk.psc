Scriptname CooldownToSet_AhniFGTalk extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_AhniFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready  Auto  

Function SetApproachReady()
	BA_CooldownToSet_FG_Ready.setvalue(1)
EndFunction

Function SetCooldownFailproof()
	;Setting a small cooldown on the initial forcegreet dialogue appears to be a necessary fail-proofing method
	float currenttimeFailproof = GameDaysPassed.getvalue()
	float cooldownFailproof =  0.001
	float setcooldownFailproof = currenttimeFailproof + cooldownFailproof
	BA_CooldownToSet_FGUniversal.setvalue(setcooldownFailproof)
EndFunction

Function SetCooldownAccepted()
	float currenttime = GameDaysPassed.getvalue()
	float r = Utility.RandomFloat(0, 0.25)
	float cooldown = 1 + r
	float setcooldown = currenttime + cooldown
	BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)

	float cooldownUniversal = Utility.RandomFloat(0, 0.083);2 hours, this cooldown is shared with Beatrice
	float setcooldownUniversal = currenttime + cooldownUniversal
	BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)

	BA_CooldownToSet_FG_Ready.setvalue(0)
EndFunction


Function SetCooldownRefused()
	;If the player refuses the interaction, the cooldown is between 72 to 84 in-game hours
	float currenttimeRefused = GameDaysPassed.getvalue()
	float rRefused = Utility.RandomFloat(0, 0.25)
	float cooldownRefused = 3 + rRefused
	float setcooldownRefused = currenttimeRefused + cooldownRefused
	BA_CooldownToSet_AhniFGTalk.setvalue(setcooldownRefused)

	BA_CooldownToSet_FG_Ready.setvalue(0)
EndFunction