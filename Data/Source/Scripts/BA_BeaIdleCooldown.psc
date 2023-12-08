Scriptname BA_BeaIdleCooldown extends Quest  

GlobalVariable Property GameDaysPassed  Auto
GlobalVariable Property BA_Cooldown_IdleDialogue  Auto
GlobalVariable Property BA_CooldownToSet_BeaIdle  Auto
Actor Property myActor Auto
Faction Property OCR_LoverRelationshipFaction  Auto

Function SetIdleCooldown()
float currenttime = GameDaysPassed.getvalue()
float setcooldown = currenttime + BA_Cooldown_IdleDialogue.getvalue()
BA_CooldownToSet_BeaIdle.setvalue(setcooldown)
EndFunction

Function IncreaseIntimacy()
int r = Utility.RandomInt(0, 100)
if r < 34
int currentrank = myActor.GetFactionRank(OCR_LoverRelationshipFaction)
int newrank = currentrank + 1
myActor.SetFactionRank(OCR_LoverRelationshipFaction, newrank)
debug.notification("Intimacy with Beatrice has increased.")
endif
EndFunction