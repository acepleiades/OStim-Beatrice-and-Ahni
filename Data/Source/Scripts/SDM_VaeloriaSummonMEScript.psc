Scriptname SDM_VaeloriaSummonMEScript extends ActiveMagicEffect  

Actor Property PlayerREF Auto
Actor Property SDM_Vaeloria Auto
GlobalVariable Property SDM_VaeloriaIsSummoned  auto
ReferenceAlias Property Alias_VaeloriaSummon  Auto

Function OnEffectStart(Actor akTarget, Actor akCaster)
	Alias_VaeloriaSummon.Clear()
	SDM_VaeloriaIsSummoned.SetValue(1)
	SDM_Vaeloria.Reset()
	float az = PlayerRef.GetAngleZ()
	SDM_Vaeloria.SetAngle(0.0, 0.0, az + 180.0)
	SDM_Vaeloria.MoveTo(PlayerREF, 200.0 * Math.sin(az), 200.0 * Math.cos(az), 0.0, false)
	Utility.Wait(0.1)
	Alias_VaeloriaSummon.ForceRefTo(SDM_Vaeloria)
	SDM_Vaeloria.SetPlayerTeammate(1)
EndFunction