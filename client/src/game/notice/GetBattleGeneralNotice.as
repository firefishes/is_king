package game.notice 
{
	import game.command.BattleDataCommand;
	/**
	 * ...
	 * @author ...
	 */
	public class GetBattleGeneralNotice extends BattleDataNotice 
	{
		
		public function GetBattleGeneralNotice(owner:int, getType:int) 
		{
			super(BattleDataCommand.GET_BATTLE_GENERAL_COMMAND, {"owner":owner, "getType":getType});
			
		}
		
		override protected function setSelfData(args:Array):void 
		{
			this._data = {"owner":args[0], "getType":args[1]};
		}
		
		public function get owner():int {
			return this.data["owner"];
		}
		
		public function get getType():int {
			return this.data["getType"];
		}
		
	}

}