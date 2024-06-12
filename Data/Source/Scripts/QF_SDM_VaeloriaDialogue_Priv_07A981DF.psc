;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_SDM_VaeloriaDialogue_Priv_07A981DF Extends Quest Hidden

;BEGIN ALIAS PROPERTY VaeloriaPrivateSummonFG
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_VaeloriaPrivateSummonFG Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE SDM_VaeloriaPrivateSummonScript
Quest __temp = self as Quest
SDM_VaeloriaPrivateSummonScript kmyQuest = __temp as SDM_VaeloriaPrivateSummonScript
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartFG()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
