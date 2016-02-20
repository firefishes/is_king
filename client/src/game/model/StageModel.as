package game.model
{
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class StageModel extends GameModel
	{
		
		private var _enemyList:Array;
		private var _stageID:String;
		private var _stageBgID:String;
		
		public function StageModel(id:String = null)
		{
			super(id);
		
		}
		
		override protected function initModel():void
		{
			super.initModel();
			
			var modelData:Object = {};//this.getModelConfig(ConfigName.BATTLE_STAGE_CONFIG, this.id);
			modelData["id"] = this.id;
			modelData["stage_bg"] = "500001_b";
			modelData["stage_id"] = "500001";
			modelData["enemy_ids"] = ["100009", "100010", "100011", "100012", "100013", "100014", "100015", "100016"];
			
			this.updateData(modelData);
		}
		
		override public function updateData(data:Object):void
		{
			super.updateData(data);
			var list:Array = data["enemy_ids"];
			var id:String, i:int, max:int = list.length;
			this._enemyList = [];
			while (i < max)
			{
				id = list[i];
				this._enemyList.push(new GeneralModel(id));
				i++;
			}
			this._stageID = data["stage_id"];
		}
		
		public function get stageID():String
		{
			return this._stageID;
		}
		
		public function get enemyList():Array
		{
			return this._enemyList;
		}
	
	}

}