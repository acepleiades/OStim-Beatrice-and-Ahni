;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__060584EB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akspeaker.SetPlayerTeammate()
BA_Ahni.SetPlayerTeammate()
BeatriceFollowerAlias.ForceRefTo(akspeaker)
AhniFollowerAlias.ForceRefTo(BA_Ahni)
PlayerFollowerCount.SetValue(1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property BA_Ahni Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property AhniFollowerAlias Auto
GlobalVariable Property PlayerFollowerCount Auto