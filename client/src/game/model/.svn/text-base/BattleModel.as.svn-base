package game.model {
	import game.utils.BattleSky;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleModel extends GameModel 
	{
		
		private var _stageModel:StageModel;
		private var _isPVE:Boolean;
		
		public function BattleModel() 
		{
			super();
			
		}
		
		public function get stageModel():StageModel 
		{
			return _stageModel;
		}
		
		public function set stageModel(value:StageModel):void 
		{
			_stageModel = value;
		}
		
		public function get isPVE():Boolean 
		{
			return _isPVE;
		}
		
		public function set isPVE(value:Boolean):void 
		{
			_isPVE = value;
		}
		
		public function get startSky():int {
			return BattleSky.DAY;//this._stageModel;
		}
		
		public function get enemyList():Array {
			return this._stageModel.enemyList;
		}
	}

}