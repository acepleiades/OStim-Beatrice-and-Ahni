;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BA_TIF__0808AF60 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
akspeaker.SetPlayerTeammate()
BA_Ahni.SetPlayerTeammate()
akspeaker.SetFactionRank(CurrentFollowerFaction, 1)
BA_Ahni.SetFactionRank(CurrentFollowerFaction, 1)
BeatriceFollowerAlias.ForceRefTo(akspeaker)
AhniFollowerAlias.ForceRefTo(BA_Ahni)
PlayerFollowerCount.SetValue(1)
BA_IsFollowing.SetValue(1)

SandboxAlias.Clear()
SandboxAlias1.Clear()
SandboxAlias2.Clear()
SandboxAlias3.Clear()
SandboxAlias4.Clear()
SandboxAlias5.Clear()
SandboxAlias6.Clear()
SandboxAlias7.Clear()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property BA_Ahni Auto
ReferenceAlias Property BeatriceFollowerAlias Auto
ReferenceAlias Property AhniFollowerAlias Auto
GlobalVariable Property PlayerFollowerCount Auto
ReferenceAlias Property SandboxAlias Auto
ReferenceAlias Property SandboxAlias1 Auto
ReferenceAlias Property SandboxAlias2 Auto
ReferenceAlias Property SandboxAlias3 Auto
ReferenceAlias Property SandboxAlias4 Auto
ReferenceAlias Property SandboxAlias5 Auto
ReferenceAlias Property SandboxAlias6 Auto
ReferenceAlias Property SandboxAlias7 Auto
Faction Property CurrentFollowerFaction  Auto  
GlobalVariable Property BA_IsFollowing Auto
