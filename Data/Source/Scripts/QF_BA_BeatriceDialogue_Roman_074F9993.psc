;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname QF_BA_BeatriceDialogue_Roman_074F9993 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Beatrice
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Beatrice Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE BA_BeatriceDialogue_RomanceVariables
Quest __temp = self as Quest
BA_BeatriceDialogue_RomanceVariables kmyQuest = __temp as BA_BeatriceDialogue_RomanceVariables
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetRomanceProgressionStage(Alias_Beatrice.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
