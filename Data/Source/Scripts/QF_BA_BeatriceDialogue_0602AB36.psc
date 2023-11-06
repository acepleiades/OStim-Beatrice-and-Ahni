;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname QF_BA_BeatriceDialogue_0602AB36 Extends Quest Hidden

;BEGIN ALIAS PROPERTY BeatriceIntroQuest30
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BeatriceIntroQuest30 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY AhniIntroQuest30
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_AhniIntroQuest30 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BeatriceFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BeatriceFollower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BeatriceWait
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BeatriceWait Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
setObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveCompleted(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
