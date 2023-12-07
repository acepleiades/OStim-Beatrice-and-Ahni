Scriptname CooldownToSet_BeaFGTalk extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_BeaFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready_Beatrice  Auto  
ReferenceAlias Property Beatrice_FG_Talk  Auto  
Actor Property BA_Beatrice  Auto  

Function SetApproachReady()
	BA_CooldownToSet_FG_Ready_Beatrice.setvalue(1)
	Beatrice_FG_Talk.ForceRefTo(BA_Beatrice)
EndFunction

Function SetCooldownAccepted()
	float currenttime = GameDaysPassed.getvalue()
	float r = Utility.RandomFloat(0, 0.25)
	float cooldown = 1 + r
	float setcooldown = currenttime + cooldown
	BA_CooldownToSet_BeaFGTalk.setvalue(setcooldown)

	float cooldownUniversal = Utility.RandomFloat(0, 0.083);2 hours, this cooldown is shared with Ahni
	float setcooldownUniversal = currenttime + cooldownUniversal
	BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)

	BA_CooldownToSet_FG_Ready_Beatrice.setvalue(0)
	Beatrice_FG_Talk.Clear()
EndFunction

Function SetCooldownRefused()
	;If the player refuses the interaction, the cooldown is between 72 to 84 in-game hours
	float currenttimeRefused = GameDaysPassed.getvalue()
	float rRefused = Utility.RandomFloat(0, 0.25)
	float cooldownRefused = 3 + rRefused
	float setcooldownRefused = currenttimeRefused + cooldownRefused
	BA_CooldownToSet_BeaFGTalk.setvalue(setcooldownRefused)

	BA_CooldownToSet_FG_Ready_Beatrice.setvalue(0)
	Beatrice_FG_Talk.Clear()
EndFunction