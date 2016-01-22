package game.model 
{
	import shipDock.manager.LocaleManager;
	import shipDock.utils.Language;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class TroopModel extends TroopPropertyModel 
	{
		
		private var _troopType:int;
		
		public function TroopModel(id:String=null) 
		{
			super(id);
		}
		
		override protected function initModel():void 
		{
			super.initModel();
			this._modelData = {
				"hp":10,
				"def":2,
				"atk":5,
				"march":1,
				"raid":1,
				"garrison":1,
				"mass":3,
				"troop_type":0
			};
			this._troopType = this._modelData["troop_type"];
			this.setName(LocaleManager.getInstance().getText("troop_name"));
			this.updateData(this._modelData);
		}
		
		public function get troopType():int 
		{
			return _troopType;
		}
	}

}