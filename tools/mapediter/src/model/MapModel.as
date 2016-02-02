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
		
	}

}