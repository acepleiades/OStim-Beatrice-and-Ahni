;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__08164CB9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BeatriceXMarker.MoveTo(BA_Beatrice)
BeatriceWaitAlias.ForceRefTo(BA_Beatrice)
AhniWaitAlias.ForceRefTo(akspeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ObjectReference Property BeatriceXMarker  Auto  
ReferenceAlias Property BeatriceWaitAlias Auto
Actor Property BA_Beatrice Auto
ReferenceAlias Property AhniWaitAlias Auto
