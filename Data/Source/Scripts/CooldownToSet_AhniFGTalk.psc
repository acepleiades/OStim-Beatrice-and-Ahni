Scriptname CooldownToSet_AhniFGTalk extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_AhniFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready_Ahni  Auto  
ReferenceAlias Property Ahni_FG_Talk  Auto  
Actor Property BA_Ahni  Auto  

Function SetApproachReady()
	BA_CooldownToSet_FG_Ready_Ahni.setvalue(1)
	Ahni_FG_Talk.ForceRefTo(BA_Ahni)
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

	BA_CooldownToSet_FG_Ready_Ahni.setvalue(0)
	Ahni_FG_Talk.Clear()
EndFunction


Function SetCooldownRefused()
	;If the player refuses the interaction, the cooldown is between 72 to 84 in-game hours
	float currenttimeRefused = GameDaysPassed.getvalue()
	float rRefused = Utility.RandomFloat(0, 0.25)
	float cooldownRefused = 3 + rRefused
	float setcooldownRefused = currenttimeRefused + cooldownRefused
	BA_CooldownToSet_AhniFGTalk.setvalue(setcooldownRefused)

	BA_CooldownToSet_FG_Ready_Ahni.setvalue(0)
	Ahni_FG_Talk.Clear()
EndFunction