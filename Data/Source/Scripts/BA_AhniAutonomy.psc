Scriptname BA_AhniAutonomy extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
GlobalVariable Property BA_CooldownToSet_AhniFGTalk  auto
GlobalVariable Property BA_CooldownToSet_FG_Ready_Ahni  Auto  
ReferenceAlias Property Ahni_FG_Talk  Auto  
Actor Property Ahni  Auto  

Function SetReady_Talk()
    ;(GetOwningQuest() as BA_AhniAutonomy).SetReady_Talk()
    Ahni_FG_Talk.Clear()
    Ahni_FG_Talk.ForceRefTo(Ahni)
    BA_CooldownToSet_FG_Ready_Ahni.setvalue(1)
    Ahni.EvaluatePackage()
EndFunction

Function SetCooldownAccepted_Talk()
    ;(GetOwningQuest() as BA_AhniAutonomy).SetCooldownAccepted_Talk()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 1 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Ahni.setvalue(0)
    Ahni_FG_Talk.Clear()
EndFunction

Function SetCooldownRefused_Talk()
    ;(GetOwningQuest() as BA_AhniAutonomy).SetCooldownRefused_Talk()
    float currenttime = GameDaysPassed.getvalue()
    float cooldownUniversal = Utility.RandomFloat(0, 0.083)
    float setcooldownUniversal = currenttime + cooldownUniversal
    BA_CooldownToSet_FGUniversal.setvalue(setcooldownUniversal)
    float r = Utility.RandomFloat(0, 0.25)
    float cooldown = 3 + r
    float setcooldown = currenttime + cooldown
    BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Ahni.setvalue(0)
    Ahni_FG_Talk.Clear()
EndFunction

Function SetCooldownWA()
    ;(GetOwningQuest() as BA_AhniAutonomy).SetCooldownWA()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.0416
    BA_CooldownToSet_AhniFGTalk.setvalue(setcooldown)
    BA_CooldownToSet_FG_Ready_Ahni.setvalue(0)
    Ahni_FG_Talk.Clear()
EndFunction