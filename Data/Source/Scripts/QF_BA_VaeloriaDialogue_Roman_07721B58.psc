;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_BA_VaeloriaDialogue_Roman_07721B58 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE SDM_VaeloriaDialogue_RomanceVariables
Quest __temp = self as Quest
SDM_VaeloriaDialogue_RomanceVariables kmyQuest = __temp as SDM_VaeloriaDialogue_RomanceVariables
;END AUTOCAST
;BEGIN CODE
kmyQuest.UpdateRomanceProgressionVariables(Vaeloria)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property Vaeloria Auto  
