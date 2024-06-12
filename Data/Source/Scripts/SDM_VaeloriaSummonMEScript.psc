Scriptname SDM_VaeloriaSummonMEScript extends ActiveMagicEffect  

Actor Property PlayerREF Auto
Actor Property SDM_Vaeloria Auto
GlobalVariable property GameDaysPassed auto
GlobalVariable property SDM_VaeloriaDialogue_CooldownPrivateSummon auto
GlobalVariable Property SDM_VaeloriaIsSummoned  auto
Keyword Property LocTypePlayerHouse Auto
Keyword Property OCR_PrivateCell Auto
Quest Property SDM_VaeloriaDialogue_Intro  Auto
Quest Property SDM_VaeloriaDialogue_PrivateSummon  Auto
ReferenceAlias Property Alias_VaeloriaSummon  Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
    if SDM_VaeloriaDialogue_PrivateSummon.IsRunning()
        SDM_VaeloriaDialogue_PrivateSummon.Stop()
    endif
    Alias_VaeloriaSummon.Clear()
    SDM_VaeloriaIsSummoned.SetValue(1)
    SDM_Vaeloria.Reset()
    float az = PlayerRef.GetAngleZ()
    SDM_Vaeloria.SetAngle(0.0, 0.0, az + 180.0)
    SDM_Vaeloria.MoveTo(PlayerREF, 200.0 * Math.sin(az), 200.0 * Math.cos(az), 0.0, false)
    Utility.Wait(0.1)
    Alias_VaeloriaSummon.ForceRefTo(SDM_Vaeloria)
    SDM_Vaeloria.SetPlayerTeammate(1)
    if SDM_VaeloriaDialogue_Intro.IsCompleted()
        PrivateSummonCheck()
    endif
EndFunction

Function PrivateSummonCheck()
    if GameDaysPassed.GetValue() > SDM_VaeloriaDialogue_CooldownPrivateSummon.GetValue()
        if PlayerREF.GetCurrentLocation().HasKeyword(LocTypePlayerHouse) ||  PlayerREF.GetCurrentLocation().HasKeyword(OCR_PrivateCell)
            SDM_VaeloriaDialogue_PrivateSummon.Start()
        endif
    endif
EndFunction