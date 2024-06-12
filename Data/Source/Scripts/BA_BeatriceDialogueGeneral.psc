Scriptname BA_BeatriceDialogueGeneral extends Quest  

Actor Property Beatrice Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable Property BA_CooldownToSet_BeaDetectCorpse  Auto
GlobalVariable Property BA_CooldownToSet_BeaObserveCombat  Auto
GlobalVariable Property BA_CooldownToSet_BeaTalkRandom  Auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
ObjectReference Property BA_BeatriceAhniInventory  Auto
ObjectReference Property BA_XMarkerReset  Auto
Quest Property OCR_OStimSequencesUtilQST  Auto
Quest Property OCR_PrivateCellsUtilQST  Auto
SPELL Property BA_Buff_BeasInsight_Spell1  Auto
SPELL Property BA_Buff_BeasInsight_Spell2  Auto
SPELL Property BA_Buff_BeasInsight_Spell3  Auto
SPELL Property BA_Buff_BeasInsight_Spell4  Auto
SPELL Property BA_Buff_BeasInsight_Spell5  Auto

Message Property BA_MSG_Beatrice_IntimacyIncrease Auto
Message Property BA_MSG_Beatrice_RomanceProgressionPossible Auto
Message Property BA_MSG_Beatrice_HangOutBuff Auto

Function HangOut(actor Beatrice)
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).HangOut(akspeaker)
    RegisterForModEvent("ostim_end", "OStimEnd")
    (OCR_OStimSequencesUtilQST as OCR_OStimSequencesUtil).ChatterNPC(Beatrice)
EndFunction

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    UnregisterForModEvent("ostim_end")
    ;Initialize Intimacy
    int Intimacy = Beatrice.GetFactionRank(OCR_Lover_Value_Intimacy)
    ;Reset actor
    BA_XMarkerReset.MoveTo(Beatrice)
    Beatrice.Reset()
    Beatrice.MoveTo(BA_XMarkerReset)
    BA_XMarkerReset.Reset()
    ;Time skip and cooldown
    OCR_GlobalFunctions.AdvanceTimeByHours(2, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.25 ;6 hours
    BA_CooldownToSet_BeaTalkRandom.setvalue(setcooldown)
    ;Intimacy increase
    if Intimacy < 100
        int newIntimacy = Intimacy + 2
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, newIntimacy)
        MiscUtil.PrintConsole("Beatrice's Intimacy value was " + Intimacy + " and is now " + newIntimacy)
        BA_MSG_Beatrice_IntimacyIncrease.Show()
        if Intimacy < 10 && newIntimacy >= 10
            BA_MSG_Beatrice_RomanceProgressionPossible.Show()
        elseif Intimacy < 20 && newIntimacy >= 20
            BA_MSG_Beatrice_RomanceProgressionPossible.Show()
        elseif Intimacy < 30 && newIntimacy >= 30
            BA_MSG_Beatrice_RomanceProgressionPossible.Show()
        elseif Intimacy < 40 && newIntimacy >= 40
            BA_MSG_Beatrice_RomanceProgressionPossible.Show()
        elseif Intimacy < 50 && newIntimacy >= 50
            BA_MSG_Beatrice_RomanceProgressionPossible.Show()
        endif
    endif
    ;Ensure maximum intimacy is 100
    if Intimacy > 100
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, 100)
    endif
    ;Apply buff
    BA_MSG_Beatrice_HangOutBuff.Show()
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell1)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell2)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell3)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell4)
    playerref.DispelSpell(BA_Buff_BeasInsight_Spell5)
    Utility.Wait(0.1)
    if Intimacy < 20
        BA_Buff_BeasInsight_Spell1.cast(playerRef, playerRef)
    elseif Intimacy < 40
        BA_Buff_BeasInsight_Spell2.cast(playerRef, playerRef)
    elseif Intimacy < 60
        BA_Buff_BeasInsight_Spell3.cast(playerRef, playerRef)
    elseif Intimacy < 80
        BA_Buff_BeasInsight_Spell4.cast(playerRef, playerRef)
    else ; This covers Intimacy > 80
        BA_Buff_BeasInsight_Spell5.cast(playerRef, playerRef)
    endif
EndEvent

function ObserveCombatCooldown()
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).ObserveCombatCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 0.01
    BA_CooldownToSet_BeaObserveCombat.setvalue(setcooldown)
endfunction

function DetectCorpseCooldown()
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).DetectCorpseCooldown()
    float currenttime = GameDaysPassed.getvalue()
    float setcooldown = currenttime + 1
    BA_CooldownToSet_BeaDetectCorpse.setvalue(setcooldown)
endfunction