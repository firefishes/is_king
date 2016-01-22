package game.notice 
{
	import flash.geom.Point;
	import game.command.BattleViewCommand;
	import game.model.GeneralModel;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class CreateBattleGeneralNotice extends BattleViewNotice 
	{
		
		public function CreateBattleGeneralNotice(model:GeneralModel, pos:Point, ownerType:int) 
		{
			super(BattleViewCommand.CREATE_BATTLE_GENERAL_COMMAND, {"model":model, "pos":pos, "ownerType":ownerType});
			
		}
		
		public function get generalModel():GeneralModel {
			return this.data["model"];
		}
		
		public function get initPos():Point {
			return this.data["pos"];
		}
		
		public function get ownerType():int {
			return this.data["ownerType"];
		}
		
	}

}