Scriptname DLPlayLutePlayer extends ReferenceAlias  

Quest Property SelfQuest  Auto  

Event OnInit()
	RegisterForCrosshairRef()
	SelfQuest = self.GetOwningQuest()
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	if (SelfQuest.IsRunning())
		if (ref)
			Actor act = ref as Actor
			if (act)
				(SelfQuest as DLPlayLuteScript).TargetActor = act
			endif
		else
			(SelfQuest as DLPlayLuteScript).TargetActor = none
		endif
	endif
EndEvent

