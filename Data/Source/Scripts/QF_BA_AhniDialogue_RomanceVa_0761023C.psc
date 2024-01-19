;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_BA_AhniDialogue_RomanceVa_0761023C Extends Quest Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BA_AhniDialogue_RomanceVariables
Quest __temp = self as Quest
BA_AhniDialogue_RomanceVariables kmyQuest = __temp as BA_AhniDialogue_RomanceVariables
;END AUTOCAST
;BEGIN CODE
kmyQuest.UpdateRomanceProgressionVariables(Ahni)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property Ahni  Auto  
