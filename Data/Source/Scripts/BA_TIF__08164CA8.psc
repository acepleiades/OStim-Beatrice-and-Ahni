;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname BA_TIF__08164CA8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Alias_NewSandboxLocation.ForceRefTo(BA_Beatrice)
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

Actor Property BA_Beatrice  Auto  
Faction Property CurrentFollowerFaction  Auto  
ReferenceAlias Property BeatriceFollowerAlias  Auto  
ReferenceAlias Property AhniFollowerAlias  Auto  
GlobalVariable Property PlayerFollowerCount  Auto  
ReferenceAlias Property Alias_NewSandboxLocation  Auto  
GlobalVariable Property BA_IsFollowing Auto
