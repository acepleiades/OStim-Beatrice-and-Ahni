Scriptname SpellFindAhniScript extends ActiveMagicEffect  

Quest Property BA_SpellFindAhniQuest  Auto  

Function OnEffectStart(Actor akTarget, Actor akCaster)
if (BA_SpellFindAhniQuest.isRunning())
BA_SpellFindAhniQuest.setstage(20)
elseif BA_SpellFindAhniQuest.start()
endif
EndFunction
