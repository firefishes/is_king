package 
{
	import action.MapEditerAction;
	import assets.mapEditer.Skin;
	import flash.display.Sprite;
	import flash.text.TextField;
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
			var i:int = 0, max:int = list.length, tile:MapTile;
			while (i < max) {
				tile = list[i][i % this.mapEditerAction.mapEditerGrids.row];
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