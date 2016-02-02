package data 
{
	import model.MapModel;
	import notice.NoticeName;
	import shipDock.framework.core.notice.Notice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapData extends DataProxy 
	{
		
		public static const NAME:String = "mapData";
		
		private var _mapModel:MapModel;
		
		public function MapData() 
		{
			super(NAME);
			
			this._mapModel = new MapModel();
		}
		
		public function setMap(data:Object):void {
			this._mapModel.updateData(data);
			
			this.notify(new Notice(NoticeName.MAP_DATA_UPDATE, this._mapModel));
		}
		
		public function addSymbol(name:String, path:String):void {
			this._mapModel.mapSymbols[name] = path;
		}
		
		public function getSymbolLibName():String {
			return this._mapModel.mapName;
		}
		
		public function getNewSymbolPath(name:String):String {
			return this.getSymbolLibName() + "/" + name;
		}
	}

}