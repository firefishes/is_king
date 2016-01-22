package game.events 
{
	import shipDock.framework.application.events.UIEvent;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class BattleGeneralEvent extends UIEvent 
	{
		
		public function BattleGeneralEvent(type:String, data:Object=null) 
		{
			super(type, false, data);
			
		}
		
	}

}