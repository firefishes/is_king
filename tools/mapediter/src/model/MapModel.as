package model 
{
	import shipDock.framework.core.model.DataModel;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapModel extends DataModel 
	{
		
		private var _data:Object
		
		public function MapModel() 
		{
			super();
		}
		
		override public function updateData(data:Object):void 
		{
			super.updateData(data);
			this._data = data;
		}
		
		public function setMapInfo(name:String, cnName:String, cellColumn:uint, cellRow:uint, bgImagePath:String):void {
			var info:Object = this.mapInfo;
			info["n"] = name;//"n":"demo"
			info["cn"] = cnName;//"cn":"示例",
			info["cw"] = cellColumn;//"cw":12,
			info["ch"] = cellRow;//"ch":6,
			info["bg"] = bgImagePath;//"bg":""
		}
		
		public function getGridValue(row:int, column:int):* {
			return this.mapGrids[row][column];
		}
		
		public function get mapData():Object {
			return this._data;
		}
		
		public function get map():Object {
			return this.mapData["map"];
		}
		
		protected function get mapInfo():Object {
			return this.mapData["m"];
		}
		
		public function get mapGrids():Array {
			return this.map["gs"];
		}
		
		public function get mapName():String {
			return this.mapInfo["n"];
		}
		
		public function get mapSymbols():Object {
			return this.mapData["symbols"];
		}
		
	}

}