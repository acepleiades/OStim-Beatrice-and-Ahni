;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname QF_BA_BeatriceAhni_MoveTo_07B6CD89 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE BA_BeatriceAhni_MoveToScript
Quest __temp = self as Quest
BA_BeatriceAhni_MoveToScript kmyQuest = __temp as BA_BeatriceAhni_MoveToScript
;END AUTOCAST
;BEGIN CODE
kmyquest.BAMoveTo()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
