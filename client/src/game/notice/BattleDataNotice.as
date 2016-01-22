package game.notice 
{
	import game.action.ActionName;
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleDataNotice extends Notice 
	{
		
		public function BattleDataNotice(subCommand:String, data:* = null) 
		{
			this.subCommand = subCommand;
			super(NoticeName.BATTLE_DATA, data);
		}
	}

}