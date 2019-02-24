Scriptname DLPlayLuteScript extends Quest  

Actor Property TargetActor  Auto  
Actor Property ActiveTargetActor  Auto  
GlobalVariable Property DLPlayingLute  Auto  

Keyword Property LocTypeInn  Auto  
Keyword Property ActorTypeNPC  Auto  
MiscObject Property Gold Auto
Actor Property Player Auto

Event OnUpdate()
	if (self._isInInn() && DLPlayingLute.GetValue() != 0)
		self._getCoins()
		RegisterForSingleUpdate(10.0)
	endif
EndEvent

Function StartGetCoins()
	if (self._isInInn())
		RegisterForSingleUpdate(10.0)
	endif
EndFunction

bool Function _isInInn()
	if (Player.IsInInterior())
		Location loc = Player.GetCurrentLocation()
		if (loc && (loc.HasKeyword(LocTypeInn)))
			return true
		endif
	endif
	
	return false
EndFunction

Function _getCoins()
	Actor[] actors = MiscUtil.ScanCellNPCs(Player, 2000.0)
	int len = actors.length
	if (len == 0)
		return
	elseif (Utility.RandomInt(0, 2) != 0)
		int idx = Utility.RandomInt(0, len - 1)
		Actor act = actors[idx]
		string name = act.GetLeveledActorBase().GetName()
		
		if (!act.IsPlayerTeammate() && act != Player && !act.IsDisabled())
			int septim = Utility.RandomInt(1, 5 + idx)
			Player.AddItem(Gold, septim)
			debug.notification("by " + name)
		endif
	endif
EndFunction