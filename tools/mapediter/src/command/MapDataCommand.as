package command 
{
	import data.MapData;
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
		
		public function MapDataCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function setMapCommand(notice:INotice):void {
			var mapData:MapData = DataProxy.getDataProxy(MapData.NAME);
			mapData.setMap(notice.data);
		}
		
	}

}