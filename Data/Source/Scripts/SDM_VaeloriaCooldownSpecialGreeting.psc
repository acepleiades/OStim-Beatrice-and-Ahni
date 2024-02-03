Scriptname SDM_VaeloriaCooldownSpecialGreeting extends Quest  

GlobalVariable property GameDaysPassed auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownSpecialGreeting auto

function SpecialGreetingCooldown()
	;(GetOwningQuest() as SDM_VaeloriaCooldownSpecialGreeting).SpecialGreetingCooldown()
	float currenttime = GameDaysPassed.getvalue()
	float setcooldown = currenttime + 1
	SDM_VaeloriaDialogue_CooldownSpecialGreeting.setvalue(setcooldown)
endfunction