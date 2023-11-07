;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08076B19 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Alias_NewSandboxLocation.ForceRefTo(akspeaker)
akspeaker.SetPlayerTeammate(false)
BA_Ahni.SetPlayerTeammate(false)
BeatriceFollowerAlias.Clear()
AhniFollowerAlias.Clear()
PlayerFollowerCount.SetValue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias property Alias_NewSandboxLocation  Auto
Actor Property BA_Ahni Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property AhniFollowerAlias Auto
GlobalVariable Property PlayerFollowerCount Auto
