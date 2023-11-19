;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08164CE5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BA_Beatrice.SetPlayerTeammate(false)
akspeaker.SetPlayerTeammate(false)
BA_Beatrice.SetFactionRank(CurrentFollowerFaction, 0)
akspeaker.SetFactionRank(CurrentFollowerFaction, 0)
BeatriceFollowerAlias.Clear()
AhniFollowerAlias.Clear()
PlayerFollowerCount.SetValue(0)
BA_IsFollowing.SetValue(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property BA_Beatrice Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property AhniFollowerAlias Auto
GlobalVariable Property PlayerFollowerCount Auto
Faction Property CurrentFollowerFaction  Auto  
GlobalVariable Property BA_IsFollowing Auto
