package game.notice 
{
	import game.utils.DataName;
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleDataSubjectNotice extends Notice 
	{
		
		public function BattleDataSubjectNotice(subCommand:String, data:*=null) 
		{
			this.subCommand = subCommand;
			super(DataName.BATTLE_DATA_SUBJECT, data);
			
		}
		
		public function get anger():Number {
			return this.data["a"];
		}
		
		public function get morale():Number {
			return this.data["m"];
		}
		
		public function get intelligence():Number {
			return this.data["i"];
		}
	}

}