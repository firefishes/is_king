package
{
	import action.MapEditerAction;
	import action.NativeDragParams;
	import assets.mapEditer.Skin;
	import command.OpenBMPFileCommand;
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.text.TextField;
	import mapEditer.MapEditerGrid;
	import mapEditer.mapTile.MapTile;
	import mapEditer.MapPannel;
	import notice.NoticeName;
	import notice.OpenBMPNotice;
	import shipDock.framework.application.component.UIAgent;
	
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
		
		override protected function initActionClass():void
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
			
			this.stage.stageWidth = 960;
			this.stage.stageHeight = 640;
			
			var mapLayer:Sprite = this.getMovieClip("mapLayer");
			var list:Array = this.mapEditerAction.setEditerGrids(0, 0);
			var mapEditerGrid:MapEditerGrid = this.mapEditerAction.mapEditerGrids;
			var i:int = 0, max:int = mapEditerGrid.gridSize, tile:MapTile, r:int, c:int;
			while (i < max)
			{
				r = int(i / this.mapEditerAction.mapEditerGrids.column);
				c = i % this.mapEditerAction.mapEditerGrids.column;
				if (list[r])
				{
					tile = list[r][c];
					mapLayer.addChild(tile);
				}
				i++;
			}
			this.shipDockAIRScriptUp();
			this.mapEditerAction.applyNativeDrag(this);
			
			this._agent.data["map"] = new MapPannel(mapLayer);
			this._agent.data["symbols"] = new MapPannel(this.getMovieClip("symbolLayer"));
		}
		
		override public function nativeDragForFile(result:NativeDragParams):void 
		{
			super.nativeDragForFile(result);
			var list:Array = result.clipboadData, splits:Array, fname:String, extension:String;
			var i:int, max:int = list.length;
			var file:File;
			var isMapFile:Boolean;
			while (i < max) {
				file = list[i];
				splits = file.url.split("/");
				fname = String(splits[splits.length - 1]);
				splits = fname.split(".");
				extension = splits[1];
				if (extension == "ikmap") {//地图配置
					file = list[max - 1];
					isMapFile = true;
					break;
				}else if (extension == "png") {
					var openBMPNotice:OpenBMPNotice = new OpenBMPNotice(OpenBMPNotice.FOR_IMPORT_SYMBOL, fname, file);
					this.mapEditerAction.sendNotice(openBMPNotice, null, OpenBMPFileCommand.IMPORT_FOR_SYMBOL_COMMAND);
				}
				i++;
			}
			(isMapFile) && this.mapEditerAction.sendNotice(NoticeName.OPEN_MAP_FILE, file);
		}
		
		override public function nativeDragForBMP(result:NativeDragParams):void 
		{
			super.nativeDragForBMP(result);
			var list:Array = result.clipboadData, splits:Array, fname:String, fpath:String;
			var i:int, max:int = list.length;
			var file:File;
			var isMapFile:Boolean;
			while (i < max) {
				file = list[i];
				splits = file.url.split("/");
				fname = String(splits[splits.length - 1]);
				fpath = (splits.slice(0, splits.lentgh - 1)).join("/");
				splits = fname.split(".");
				if (splits[1] == "png") {//地图配置
					file = list[max - 1];
					isMapFile = true;
					break;
				}
				i++;
			}
			(isMapFile) && this.mapEditerAction.sendNotice(NoticeName.OPEN_MAP_FILE, file);
		}
		
		private function get infoText():TextField {
			return this.getTextField("infoText");
		}
		
		private function get cmdText():TextField
		{
			return this.getTextField("cmdText");
		}
		
		private function get mapEditerAction():MapEditerAction
		{
			return this._action as MapEditerAction;
		}
	}

}