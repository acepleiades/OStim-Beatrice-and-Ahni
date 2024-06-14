Scriptname BA_BeatriceAhni_MoveToScript extends Quest  

Actor Property BA_Beatrice  Auto
Actor Property BA_Ahni  Auto
Actor Property playerref  Auto
SPELL Property BA_BeatriceAhni_MoveToSpell  Auto  

function BAMoveTo()
	BA_Beatrice.MoveTo(playerref)
	BA_BeatriceAhni_MoveToSpell.Cast(BA_Beatrice, BA_Beatrice)
	BA_Ahni.MoveTo(playerref)
	BA_BeatriceAhni_MoveToSpell.Cast(BA_Ahni, BA_Ahni)
endfunction