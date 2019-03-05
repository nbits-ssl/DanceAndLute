Scriptname DLPlayLuteEffect extends activemagiceffect  

Idle Property IdleLuteStart Auto
Idle Property IdleStop_Loose Auto
Quest Property DLPlayLuteQuest  Auto  
Sound Property DLLuteSound Auto
GlobalVariable Property DLPlayingLute  Auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if (DLPlayingLute.GetValue() != 0)
		self.finish()
	else
		DLPlayLuteScript questScript = (DLPlayLuteQuest as DLPlayLuteScript)
		Game.ForceThirdPerson()
		DLPlayingLute.SetValue(DLLuteSound.Play(akCaster))
		
		Actor target = questScript.TargetActor
		if (target)
			Actor player = Game.GetPlayer()
			target.SetAngle(0.0, 0.0, player.GetAngleZ())
			debug.SendAnimationEvent(target, "DLPlayLuteDance")
			questScript.ActiveTargetActor = target
		endif
		
		Armor shield = akCaster.GetEquippedShield()
		if (shield)
			akCaster.UnEquipItem(shield)
		endif
		
		akCaster.PlayIdle(IdleLuteStart)
		questScript.StartGetCoins()
	endif
EndEvent

Function finish()
	Actor player = Game.GetPlayer()
	Sound.StopInstance(DLPlayingLute.GetValue() as int)
	DLPlayingLute.SetValue(0)
	player.PlayIdle(IdleStop_Loose)
	
	DLPlayLuteScript questScript = (DLPlayLuteQuest as DLPlayLuteScript)
	Actor target = questScript.ActiveTargetActor
	if (target)
		debug.SendAnimationEvent(target, "IdleForceDefaultState")
	endif
	questScript.ActiveTargetActor = none
EndFunction

