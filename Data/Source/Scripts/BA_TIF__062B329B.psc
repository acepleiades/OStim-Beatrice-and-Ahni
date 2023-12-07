;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BA_TIF__062B329B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetOwningQuest() as BA_AhniIdleCooldown).SetIdleCooldown()
(GetOwningQuest() as BA_AhniIdleCooldown).SetDailyIdleCooldown()
(GetOwningQuest() as BA_AhniIdleCooldown).IncreaseIntimacy()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
