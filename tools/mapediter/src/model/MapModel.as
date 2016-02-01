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
		
		public function getGridValue(row:int, column:int):void {
			return this.mapGrids[row][column];
		}
		
		public function get mapData():Object {
			return this._data;
		}
		
		public function get mapGrids():Array {
			return this._data["grids"];
		}
		
		protected function get mapInfo():Object {
			return this._data["m"];
		}
		
		public function get mapName():String {
			return this.mapInfo["n"];
		}
		
	}

}