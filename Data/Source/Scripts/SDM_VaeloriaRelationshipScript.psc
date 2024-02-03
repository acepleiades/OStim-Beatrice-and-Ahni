Scriptname SDM_VaeloriaRelationshipScript extends Quest  

Actor Property SDM_Vaeloria Auto
Faction Property OCR_Lover_Value_Intimacy  Auto
GlobalVariable property GameDay auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property GameHour auto
GlobalVariable property GameMonth auto
GlobalVariable property GameYear auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownFlatter auto
OCR_OStimSequencesUtil Property Util Auto

function Flatter(actor actor1)
    ;(GetOwningQuest() as SDM_VaeloriaRelationshipScript).Flatter(akspeaker)
    RegisterForModEvent("ostim_end", "OStimEnd")
    Util.Court(actor1)
endfunction

Event OStimEnd(string eventName, string strArg, float numArg, Form sender)
    OCR_GlobalFunctions.AdvanceTimeByHours(1, GameHour, GameDay, GameDaysPassed, GameMonth, GameYear)
    float currenttime = GameDaysPassed.getvalue()
	float setcooldown = currenttime + 0.25 ;6 hours
	SDM_VaeloriaDialogue_CooldownFlatter.setvalue(setcooldown)
    int currentrank = SDM_Vaeloria.GetFactionRank(OCR_Lover_Value_Intimacy)
    if currentrank < 100
        int newrank = currentrank + 2
        SDM_Vaeloria.SetFactionRank(OCR_Lover_Value_Intimacy, newrank)
        MiscUtil.PrintConsole("Vaeloria's Intimacy value was " + currentrank + " and is now " + newrank)
        debug.notification("Intimacy with Vaeloria has increased.")
        if currentrank < 10 && newrank >= 10
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 20 && newrank >= 20
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 30 && newrank >= 30
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 40 && newrank >= 40
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        elseif currentrank < 50 && newrank >= 50
            debug.notification("You may progress your relationship with Vaeloria at a private location.")
        endif
    endif
    UnregisterForModEvent("ostim_end")
EndEvent