package game.data 
{
	import game.model.GeneralModel;
	import game.model.PositionsModel;
	import game.utils.CampType;
	import shipDock.framework.core.observer.DataProxy;
	import shipDock.framework.core.utils.HashMap;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class CampData extends DataProxy 
	{
		
		public static const CAMP_DATA:String = "campData";
		
		private var _camps:HashMap;
		
		public function CampData() 
		{
			super(CAMP_DATA);
			
			this._camps = new HashMap();
			this._camps.put(CampType.ATK, new PositionsModel(CampType.ATK + "CampData"));
			this._camps.put(CampType.DEF, new PositionsModel(CampType.DEF + "CampData"));
			
		}
		
		public function updateCampByServer(data:Array, campType:String = "atk"):void {
			var i:int = 0;
			var max:int = data.length;
			while (i < max) {
				this.setCampBySite(i, data[i], campType);
				i++;
			}
		}
		
		public function setCampBySite(siteName:int, value:GeneralModel, campType:String = "atk"):void {
			var list:PositionsModel = this._camps.getValue(campType) as PositionsModel;
			list.setGeneral(siteName, value);
			this._camps.put(campType, list);
		}
		
		public function get atkCamp():Array {
			return (this._camps.getValue(CampType.ATK) as PositionsModel).positionsList;
		}
		
		public function get defCamp():Array {
			return (this._camps.getValue(CampType.DEF) as PositionsModel).positionsList;
		}
		
	}

}