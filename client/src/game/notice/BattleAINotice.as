package game.notice 
{
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleAINotice extends Notice 
	{
		
		public function BattleAINotice(subCommand:String, data:*=null) 
		{
			this.subCommand = subCommand;
			super(NoticeName.BATTLE_AI, data);
			
		}
		
	}

}