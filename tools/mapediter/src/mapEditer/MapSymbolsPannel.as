package mapEditer 
{
	import action.MapSymbolsPannelAction;
	import shipDock.framework.application.component.UIAgent;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapSymbolsPannel extends UIAgent 
	{
		
		public function MapSymbolsPannel(target:*) 
		{
			super(target);
			this.setAction(new MapSymbolsPannelAction());
		}
		
		
		
	}

}