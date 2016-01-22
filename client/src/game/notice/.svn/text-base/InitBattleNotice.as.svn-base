package game.notice 
{
	import game.command.BattleDataCommand;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class InitBattleNotice extends BattleDataNotice 
	{
		
		public function InitBattleNotice(battleID:String, isPVE:Boolean = true) 
		{
			super(BattleDataCommand.INIT_BATTLE_COMMAND, { "battleID":battleID, "isPVE":isPVE});
			
		}
		
		public function get battleID():String {
			return this.data["battleID"];
		}
		
		public function get isPVE():Boolean {
			return this.data["isPVE"];
		}
		
	}

}