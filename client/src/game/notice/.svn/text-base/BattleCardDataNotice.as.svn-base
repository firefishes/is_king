package game.notice 
{
	import game.model.BattleCardModel;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleCardDataNotice extends BattleDataNotice 
	{
		
		public function BattleCardDataNotice(ownerType:int, cardIndex:int = -1, cardModel:BattleCardModel = null) 
		{
			super(null, {"ownerType":ownerType, "cardIndex":cardIndex, "cardModel":cardModel});
		}
		
		override protected function setSelfData(args:Array):void 
		{
			this.data["ownerType"] = args[0];
			this.data["cardIndex"] = args[1];
			this.data["cardModel"] = args[2];
		}
		
		public function get ownerType():int {
			return this.data["ownerType"];
		}
		
		public function get cardIndex():int {
			return this.data["cardIndex"];
		}
		
		public function get cardModel():BattleCardModel {
			return this.data["cardModel"];
		}
		
	}

}