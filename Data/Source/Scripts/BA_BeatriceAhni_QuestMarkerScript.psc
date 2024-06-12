Scriptname BA_BeatriceAhni_QuestMarkerScript extends Quest  

Quest Property BA_BeatriceAhni_QuestMarker  Auto
Quest Property BA_BeatriceDialogue_General  Auto

Function StartUp()
	if BA_BeatriceDialogue_General.GetStage() >= 30
		BA_BeatriceAhni_QuestMarker.SetStage(10)
	else
		BA_BeatriceAhni_QuestMarker.SetStage(5)
	endif
EndFunction