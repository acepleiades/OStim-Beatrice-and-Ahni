;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_BA_BeatriceAhni_QuestMark_07B16C02 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Beatrice
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Beatrice Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BA_BeatriceAhni_QuestMarkerScript
Quest __temp = self as Quest
BA_BeatriceAhni_QuestMarkerScript kmyQuest = __temp as BA_BeatriceAhni_QuestMarkerScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartUp()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
CompleteAllObjectives()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
