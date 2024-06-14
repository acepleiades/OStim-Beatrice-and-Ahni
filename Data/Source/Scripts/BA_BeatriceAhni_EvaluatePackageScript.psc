Scriptname BA_BeatriceAhni_EvaluatePackageScript extends Quest  

GlobalVariable Property GameDaysPassed  auto
GlobalVariable Property BA_CooldownToSet_FGUniversal  auto
Actor Property BA_Beatrice  Auto
Actor Property BA_Ahni  Auto

function BAEvaluatePackage()
	float currenttime = GameDaysPassed.getvalue()
	if currenttime > BA_CooldownToSet_FGUniversal.getvalue()
		BA_CooldownToSet_FGUniversal.setvalue(currenttime + 0.01)
	endif
	BA_Beatrice.EvaluatePackage()
	BA_Ahni.EvaluatePackage()
endfunction
