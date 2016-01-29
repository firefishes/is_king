package action
{
	import flash.geom.Point;
	import mapEditer.MapEditerGrid;
	import mapEditer.mapTile.MapTile;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerAction extends AIRMainAction
	{
		private var _mapEditerGrids:MapEditerGrid;
		
		public function MapEditerAction()
		{
			super();
		
		}
		
		public function setEditerGrids(x:Number, y:Number):Array
		{
			var result:Array = [];
			this._mapEditerGrids = new MapEditerGrid(x, y, 5, 12, 936, 435);
			var point:Point, tile:MapTile, list:Array = [], i:int = 0, r:int = 0, c:int = 0;
			var max:int = this._mapEditerGrids.row * this._mapEditerGrids.column;
			while (i < max) {
				if (c > this._mapEditerGrids.column - 1) {
					result.push(list);
					list = [];
					c = 0;
					r++;
				}
				point = this._mapEditerGrids.getPosByGrid(r, c);
				tile = new MapTile(this._mapEditerGrids.gridWidth, this._mapEditerGrids.gridHeight);
				tile.x = point.x;
				tile.y = point.y;
				list.push(tile);
				c++;
				i++;
			}
			result.push(list);
			return result;
		}
		
		public function get mapEditerGrids():MapEditerGrid 
		{
			return _mapEditerGrids;
		}
	
	}

}