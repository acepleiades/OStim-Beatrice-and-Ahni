Scriptname SDM_BleedOutVanish extends ObjectReference  

Actor Property myActor Auto
Activator Property SummonTargetFXActivator Auto
ReferenceAlias Property mySummonAlias  Auto

Event OnEnterBleedout()
	mySummonAlias.Clear()
	myActor.PlaceAtMe(SummonTargetFXActivator, 1)
	Utility.Wait(0.33)
	myActor.MoveToMyEditorLocation()
endEvent