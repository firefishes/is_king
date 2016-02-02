package action 
{
	import data.MapData;
	import model.MapModel;
	import notice.NoticeName;
	import shipDock.framework.core.action.Action;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapSymbolsPannelAction extends Action 
	{
		
		public function MapSymbolsPannelAction(name:String=null) 
		{
			super(name);
			
		}
		
		override protected function setCommand():void 
		{
			super.setCommand();
			
			this.bindDataProxy(MapData.NAME);
		}
		
		override public function notify(notice:INotice):* 
		{
			var result:* = super.notify(params);
			if (params.name == NoticeName.MAP_DATA_UPDATE) {
				
				var model:MapModel = notice.data;
				
			}
		}
		
	}

}