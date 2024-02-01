Scriptname SDM_BleedOutVanish extends ObjectReference  

Activator Property SummonTargetFXActivator Auto
Actor Property myActor Auto
GlobalVariable Property myActorSummonedGlobal  auto
ReferenceAlias Property mySummonAlias  Auto

Event OnEnterBleedout()
	mySummonAlias.Clear()
	myActorSummonedGlobal.SetValue(0)
	myActor.PlaceAtMe(SummonTargetFXActivator, 1)
	Utility.Wait(0.33)
	myActor.MoveToMyEditorLocation()
	myActor.SetPlayerTeammate(0)
endEvent