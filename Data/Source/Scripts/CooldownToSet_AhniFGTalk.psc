Scriptname CooldownToSet_AhniFGTalk extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_AhniFGTalk  auto

Function SetCooldown()
float currenttime = GameDaysPassed.getvalue()
float r = Utility.RandomFloat(0, 0.25)
float cooldown = 1 + r
float setcooldown = currenttime + cooldown
BA_CooldownToSet_FGUniversal.setvalue(setcooldown)
BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)
EndFunction