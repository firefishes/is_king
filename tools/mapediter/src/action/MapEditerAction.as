package action
{
	import command.MapEditerStartUpCommand;
	import command.NewMapCommand;
	import data.MapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mapEditer.MapEditerGrid;
	import mapEditer.mapTile.MapTile;
	import notice.EditerOptionChangeNotice;
	import notice.NoticeName;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerAction extends AIRMainAction
	{
		private var _mapEditerGrids:MapEditerGrid;
		private var _currentOptions:int = MapEditerOption.NORMAL;
		
		public function MapEditerAction()
		{
			super(MapEditerStartUpCommand);
		
		}
		
		override protected function get preregisteredCommand():Array
		{
			return super.preregisteredCommand.concat([
				NoticeName.MAP_EDITER,
				NoticeName.NEW_MAP_FILE,
				NoticeName.OPEN_MAP_FILE, 
				NoticeName.MAP_DATA, 
				NoticeName.OPEN_BMP_FILE,
			]);
		}
		
		public function newButtonHandler(event:MouseEvent):void {
			this.sendNotice(NoticeName.NEW_MAP_FILE, null, NewMapCommand.POPUP_CREATE_PANNEL_COMMAND);
		}
		
		public function saveButtonHandler(event:MouseEvent):void {
			
		}
		
		public function symbolButtonHandler(event:MouseEvent):void {
			
		}
		
		public function bgButtonHandler(event:MouseEvent):void {
			
		}
		
		public function changeOptions(value:int):void {
			this._currentOptions = value;
			var msg:EditerOptionChangeNotice = new EditerOptionChangeNotice(this._currentOptions);
			this.sendNotice(msg);
		}
		
		public function setEditerGrids(x:Number, y:Number):Array
		{
			var result:Array = [];
			this._mapEditerGrids = new MapEditerGrid(x, y, 5, 12, 936, 435);
			var point:Point, tile:MapTile, list:Array = [], i:int = 0, r:int = 0, c:int = 0;
			var max:int = this._mapEditerGrids.row * this._mapEditerGrids.column;
			while (i < max)
			{
				if (c > this._mapEditerGrids.column - 1)
				{
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