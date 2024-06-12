Scriptname SDM_Vaeloria_QuestMarkerScript extends Quest  

Quest Property SDM_Vaeloria_QuestMarker  Auto
Quest Property SDM_VaeloriaDialogue_Intro  Auto

Function StartUp()
	if SDM_VaeloriaDialogue_Intro.IsCompleted()
		SDM_Vaeloria_QuestMarker.SetStage(10)
	else
		SDM_Vaeloria_QuestMarker.SetStage(5)
	endif
EndFunction