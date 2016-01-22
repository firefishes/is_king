package game.notice 
{
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleOptionPannelNotice extends Notice 
	{
		
		public function BattleOptionPannelNotice(subCommand:String, data:*=null) 
		{
			this.subCommand = subCommand;
			super(NoticeName.BATTLE_OPTION_PANNEL, data);
			
		}
		
	}

}