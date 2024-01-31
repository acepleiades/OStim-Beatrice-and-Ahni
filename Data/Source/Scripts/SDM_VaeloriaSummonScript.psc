Scriptname SDM_VaeloriaSummonScript extends Quest  

Activator Property SummonTargetFXActivator  Auto  
ReferenceAlias Property Alias_VaeloriaSummon  Auto

Function Dismiss(actor actor1)
	Alias_VaeloriaSummon.Clear()
	Utility.Wait(1)
	actor1.PlaceAtMe(SummonTargetFXActivator, 1)
	Utility.Wait(0.33)
	actor1.MoveToMyEditorLocation()
endfunction