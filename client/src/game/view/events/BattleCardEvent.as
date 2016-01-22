package game.view.events
{
	import shipDock.framework.application.events.UIEvent;
	
	public class BattleCardEvent extends UIEvent
	{
		
		public static const BATTLE_CARD_SHOWED_EVENT:String = "battleCardShowedEvent";
		public static const BATTLE_CARD_ICON_READY_EVENT:String = "battleCardIconShowReadyEvent";
		
		public function BattleCardEvent(type:String, data:Object=null)
		{
			super(type, false, data);
		}
	}
}