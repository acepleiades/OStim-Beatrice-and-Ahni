Scriptname AhniCombat extends ObjectReference  

spell property spell_Stoneflesh auto
spell property spell_BoundBow auto

event OnCombatStateChanged(Actor akTarget, Int aeCombatState)
    if aeCombatState == 1
        spell_Stoneflesh.Cast(self as objectreference, self as objectreference)
        spell_BoundBow.Cast(self as objectreference, self as objectreference)
    endIf
endEvent