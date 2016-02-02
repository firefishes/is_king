package mapEditer 
{
	import action.MapPannelAction;
	import shipDock.framework.application.component.UIAgent;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapPannel extends UIAgent 
	{
		
		public function MapPannel(target:*) 
		{
			super(target);
			this.setAction(new MapPannelAction());
		}
		
		public function mapDataUpdate(notice:INotice):void {
			
		}
		
	}

}