package action
{
	import command.MapEditerStartUpCommand;
	import data.MapData;
	import flash.geom.Point;
	import mapEditer.MapEditerGrid;
	import mapEditer.mapTile.MapTile;
	import notice.NoticeName;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerAction extends AIRMainAction
	{
		private var _mapEditerGrids:MapEditerGrid;
		
		public function MapEditerAction()
		{
			super(MapEditerStartUpCommand);
			
		}
		
		override protected function setCommand():void 
		{
			super.setCommand();
			
			this.bindDataProxy(MapData.NAME);
		}
		
		override public function notify(params:INotice):* 
		{
			var result:* = super.notify(params);
			if (params.name == NoticeName.MAP_DATA_UPDATE) {
				this
			}
		}
		
		override protected function get preregisteredCommand():Array 
		{
			return super.preregisteredCommand.concat([
				NoticeName.OPEN_MAP_FILE,
				NoticeName.MAP_DATA
			]);
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