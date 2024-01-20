Scriptname BA_BeatriceAutonomy extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_BeaFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready_Beatrice  Auto  
ReferenceAlias Property Beatrice_FG_Talk  Auto  
Actor Property Beatrice  Auto  

Function SetReady_Talk()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetReady_Talk()
    Beatrice_FG_Talk.Clear()
    Beatrice_FG_Talk.ForceRefTo(Beatrice)
    BA_CooldownToSet_FG_Ready_Beatrice.setvalue(1)
    Beatrice.EvaluatePackage()
EndFunction

Function SetCooldownAccepted_Talk()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownAccepted_Talk()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 1 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Beatrice.setvalue(0)
    Beatrice_FG_Talk.Clear()
EndFunction

Function SetCooldownRefused_Talk()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownRefused_Talk()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 3 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_BeaFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Beatrice.setvalue(0)
    Beatrice_FG_Talk.Clear()
EndFunction

Function SetCooldownWA()
    ;(GetOwningQuest() as BA_BeatriceAutonomy).SetCooldownWA()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0416
    BA_CooldownToSet_BeaFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Beatrice.setvalue(0)
    Beatrice_FG_Talk.Clear()
EndFunction