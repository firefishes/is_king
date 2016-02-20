package command 
{
	import data.MapData;
	import notice.CreateNewMapNotice;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapDataCommand extends Command 
	{
		/**设置地图数据*/
		public static const SET_MAP_COMMAND:String = "setMapCommand";
		public static const SET_MAP_INFO_COMMAND:String = "setMapInfoCommand";
		
		private var _mapData:MapData;
		
		public function MapDataCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
			this._mapData = DataProxy.getDataProxy(MapData.NAME);
		}
		
		public function setMapCommand(message:INotice):void {
			this._mapData.setMap(message.data);
		}
		
		public function setMapInfoCommand(message:INotice):void {
			var source:* = message.data;
			this._mapData.setMapInfo(source.mapName, source.cnName, source.cellColumn, source.cellRow, source.bgImagePath);
		}
		
	}

}