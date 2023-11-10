;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__061884F0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float currenttime = GameDaysPassed.getvalue()
float setcooldown = currenttime + 0.17 ;around 4 hours
BA_CooldownToSet_AhniIdle.setvalue(setcooldown)

if akspeaker.GetFactionRank(OCR_LoverRelationshipFaction) < 20
int currentrank = akspeaker.GetFactionRank(OCR_LoverRelationshipFaction)
int newrank = currentrank + 1
akspeaker.SetFactionRank(OCR_LoverRelationshipFaction, newrank)
debug.notification("Intimacy with Ahni has increased.")
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property OCR_LoverRelationshipFaction  Auto  
GlobalVariable Property GameDaysPassed  Auto  
GlobalVariable Property BA_CooldownToSet_AhniIdle  Auto  
