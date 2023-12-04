Scriptname BA_AhniDialogue_IntimacyIncrease extends Quest  

GlobalVariable Property GameHour  auto
Actor Property myActor Auto
Faction Property OCR_LoverRelationshipFaction  Auto
SPELL Property BA_Buff_AhnisJoy_Spell  Auto  
Actor Property playerRef Auto

Function SpendTimeIntimacy()

game.disablePlayerControls()
Game.FadeOutGame(false, true, 2.0, 1.0)
Utility.Wait(1)
float currenthour = GameHour.GetValue()
float newtime = currenthour + 2
GameHour.SetValue(newtime)
Utility.Wait(1)
Debug.Notification("Spending time with Ahni was enjoyable.")

int r = Utility.RandomInt(0, 100)
if r < 41
int currentrank = myActor.GetFactionRank(OCR_LoverRelationshipFaction)
int newrank = currentrank + 1
myActor.SetFactionRank(OCR_LoverRelationshipFaction, newrank)
debug.notification("Intimacy with Ahni has increased.")
endif

BA_Buff_AhnisJoy_Spell.cast(playerRef, playerRef)

Game.EnablePlayerControls()
EndFunction