package 
{
	import action.MapEditerAction;
	import assets.mapEditer.Skin;
	import flash.display.Sprite;
	import flash.text.TextField;
	import mapEditer.MapEditerGrid;
	import mapEditer.mapTile.MapTile;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class Main extends AIRApplication 
	{
		
		
		public function Main():void 
		{
			super();
		}
		
		override protected function initSOName():void
		{
			this._soName = "isKingMapEditer";
		}
		
		override protected function initSkinClass():void 
		{
			this._skinClass = Skin;
		}
		
		override protected function initActoinClass():void 
		{
			this._actionClass = MapEditerAction;
		}
		
		override protected function setLogText():void 
		{
			this._infoText = this.infoText;
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			var mapLayer:Sprite = this.getMovieClip("mapLayer");
			var list:Array = this.mapEditerAction.setEditerGrids(mapLayer.x, mapLayer.y);
			var mapEditerGrid:MapEditerGrid = this.mapEditerAction.mapEditerGrids;
			var i:int = 0, max:int = mapEditerGrid.row * mapEditerGrid.column, tile:MapTile, r:int, c:int;
			while (i < max) {
				r = int(i / this.mapEditerAction.mapEditerGrids.column);
				c = i % this.mapEditerAction.mapEditerGrids.row;
				tile = list[c][r];
				mapLayer.addChild(tile);
				i++;
			}
		}
		
		private function get infoText():TextField {
			return this.getTextField("infoText");
		}
		
		private function get cmdText():TextField
		{
			return this.getTextField("cmdText");
		}
		
		private function get mapEditerAction():MapEditerAction {
			return this._action as MapEditerAction;
		}
	}
	
}