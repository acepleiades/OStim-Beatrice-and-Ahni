Scriptname BA_AhniDialogue_IntimacyIncrease extends Quest  

GlobalVariable Property GameHour  auto
Actor Property myActor Auto
Faction Property OCR_LoverRelationshipFaction  Auto
Actor Property playerRef Auto
SPELL Property BA_Buff_AhnisJoy_Spell1  Auto  
SPELL Property BA_Buff_AhnisJoy_Spell2  Auto  
SPELL Property BA_Buff_AhnisJoy_Spell3  Auto  
SPELL Property BA_Buff_AhnisJoy_Spell4  Auto  
SPELL Property BA_Buff_AhnisJoy_Spell5  Auto  

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

int myrank  = myActor.GetFactionRank(OCR_LoverRelationshipFaction)
playerref.DispelSpell(BA_Buff_AhnisJoy_Spell1)
playerref.DispelSpell(BA_Buff_AhnisJoy_Spell2)
playerref.DispelSpell(BA_Buff_AhnisJoy_Spell3)
playerref.DispelSpell(BA_Buff_AhnisJoy_Spell4)
playerref.DispelSpell(BA_Buff_AhnisJoy_Spell5)
if myrank  < 20
BA_Buff_AhnisJoy_Spell1.cast(playerRef, playerRef)
endif
if myrank  >= 20
	if myrank  < 40
	BA_Buff_AhnisJoy_Spell2.cast(playerRef, playerRef)
	endif
endif
if myrank  >= 40
	if myrank  < 60
	BA_Buff_AhnisJoy_Spell3.cast(playerRef, playerRef)
	endif
endif
if myrank  >= 60
	if myrank  < 80
	BA_Buff_AhnisJoy_Spell4.cast(playerRef, playerRef)
	endif
endif
if myrank  > 80
BA_Buff_AhnisJoy_Spell5.cast(playerRef, playerRef)
endif

Game.EnablePlayerControls()
EndFunction