;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_SDM_Vaeloria_QuestMarker_07B16C01 Extends Quest Hidden

;BEGIN ALIAS PROPERTY VaeloriaBook
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_VaeloriaBook Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE SDM_Vaeloria_QuestMarkerScript
Quest __temp = self as Quest
SDM_Vaeloria_QuestMarkerScript kmyQuest = __temp as SDM_Vaeloria_QuestMarkerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUp()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
CompleteAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
SetObjectiveCompleted(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
