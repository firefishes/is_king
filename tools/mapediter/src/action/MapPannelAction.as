package action 
{
	import data.MapData;
	import notice.NoticeName;
	import shipDock.framework.core.action.Action;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.notice.InvokeProxyedNotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapPannelAction extends Action 
	{
		
		public function MapPannelAction() 
		{
			super();
			
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
				this.callProxyed("mapDataUpdate", null, false);
			}
		}
		
	}

}