;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BA_TIF__0620C052 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float currenttime = GameDaysPassed.getvalue()
float setcooldown = currenttime + 0.25 ;6 hours
BA_CooldownToSet_BeaTalkRandom.setvalue(setcooldown)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property BA_CooldownToSet_BeaTalkRandom  Auto
