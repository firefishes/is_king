package game.notice 
{
	import game.command.BattleViewCommand;
	import game.model.GeneralModel;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class AddBattleWordNotice extends BattleViewNotice 
	{
		
		public function AddBattleWordNotice(wonerType:int, genralModel:GeneralModel, wordText:String = "") 
		{
			super(BattleViewCommand.ADD_BATTLE_WORD_COMMAND, {"ownerType":ownerType, "genralModel":genralModel, "wordText":wordText});
			
		}
		
		override protected function setSelfData(args:Array):void 
		{
			this.data["ownerType"] = args[0];
			this.data["genralModel"] = args[1];
			this.data["wordText"] = args[2];
		}
		
		public function get genralModel():GeneralModel {
			return this.data["genralModel"];
		}
		
		public function get ownerType():int {
			return this.data["ownerType"];
		}
		
		public function get wordText():String {
			return this.data["wordText"];
		}
	}

}