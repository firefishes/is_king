package game.notice 
{
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleViewNotice extends Notice
	{
		
		public function BattleViewNotice(subCommand:String, data:*=null) 
		{
			this.subCommand = subCommand;
			super(NoticeName.BATTLE_VIEW, data);
			
		}
		
	}

}