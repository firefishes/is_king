package game.notice 
{
	import game.command.BattleViewCommand;
	import game.model.BattleCardModel;
	import game.model.SkillModel;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class AddBattleCardToViewNotice extends BattleViewNotice 
	{
		
		public function AddBattleCardToViewNotice(battleCardModel:BattleCardModel, cardIndex:int = 0) 
		{
			super(BattleViewCommand.ADD_BATTLE_CARD_TO_VIEW_COMMAND, {"battleCardModel":battleCardModel, "cardIndex":cardIndex});
		}
		
		override protected function setSelfData(args:Array):void 
		{
			this.data["battleCardModel"] = args[0];
			this.data["cardIndex"] = args[1];
		}
		
		public function get battleCardModel():BattleCardModel {
			return this.data["battleCardModel"];
		}
		
		public function get cardIndex():int {
			return this.data["cardIndex"];
		}
		
		public function get skillModel():SkillModel {
			return (this.battleCardModel != null) ? this.battleCardModel.skillModel : null;
		}
		
		public function get ownerType():int {
			return (this.battleCardModel != null) ? this.battleCardModel.ownerType : -1;
		}
		
	}

}