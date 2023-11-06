;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0602FC5C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BA_Beatrice.setrelationshiprank(game.getplayer(), 1)
akspeaker.setrelationshiprank(game.getplayer(), 1)
MyAlias.Clear()
MyAlias1.Clear()
MyQuest.SetStage(40)

BA_Beatrice.SetPlayerTeammate()
akspeaker.SetPlayerTeammate()
BeatriceFollowerAlias.ForceRefTo(BA_Beatrice)
AhniFollowerAlias.ForceRefTo(akspeaker)
PlayerFollowerCount.SetValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property myQuest  Auto  
ReferenceAlias Property myAlias  Auto  
ReferenceAlias Property myAlias1  Auto  
Actor Property BA_Beatrice Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property AhniFollowerAlias Auto
GlobalVariable Property PlayerFollowerCount Auto
