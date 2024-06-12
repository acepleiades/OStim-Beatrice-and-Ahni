;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BA_TIF__0602FC4D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
MyActor.Enable()
MyAlias.ForceRefTo(akspeaker)
MyAlias1.ForceRefTo(MyActor)
GetOwningQuest().setstage(30)
BA_BeatriceAhni_QuestMarker.setstage(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property myActor  Auto  
ReferenceAlias Property myAlias  Auto  
ReferenceAlias Property myAlias1  Auto  

Quest Property BA_BeatriceAhni_QuestMarker  Auto  
