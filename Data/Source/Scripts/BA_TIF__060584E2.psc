;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BA_TIF__060584E2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BeatriceXMarker.MoveTo(akspeaker)
BeatriceWaitAlias.ForceRefTo(akspeaker)
AhniWaitAlias.ForceRefTo(BA_Ahni)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property BeatriceXMarker  Auto  
ReferenceAlias Property BeatriceWaitAlias Auto
ReferenceAlias Property AhniWaitAlias Auto
Actor Property BA_Ahni Auto
