Scriptname BA_BeatriceDialogueGeneral extends Quest  

Actor Property Beatrice Auto
Actor Property playerRef Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
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
        debug.notification("Intimacy with Beatrice has increased.")
        if Intimacy < 10 && newIntimacy >= 10
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 20 && newIntimacy >= 20
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 30 && newIntimacy >= 30
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 40 && newIntimacy >= 40
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        elseif Intimacy < 50 && newIntimacy >= 50
            debug.notification("You may progress your relationship with Beatrice at a private location.")
        endif
    endif
    ;Ensure maximum intimacy is 100
    if Intimacy > 100
        Beatrice.SetFactionRank(OCR_Lover_Value_Intimacy, 100)
    endif
    ;Apply buff
    Debug.Notification("Spending time with Beatrice was insightful.")
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

function Camp(actor actor1)
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).Camp(akspeaker)
    (OCR_PrivateCellsUtilQST as OCR_PrivateCellsUtil).FollowerCamping(actor1)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
endfunction

function Inventory()
    ;(GetOwningQuest() as BA_BeatriceDialogueGeneral).Inventory()
    BA_BeatriceAhniInventory.Activate(PlayerREF)
endfunction