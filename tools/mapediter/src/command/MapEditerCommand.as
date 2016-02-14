package command 
{
	import action.MapEditerAction;
	import notice.EditerOptionChangeNotice;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerCommand extends Command 
	{
		
		public static const MAP_OPTION_CHANGE_COMMAND:String = "mapOptionChangeCommand";
		public static const MAP_OPTION_UPDATE_COMMAND:String = "mapOptionUpdateCommand";
		
		public function MapEditerCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function mapOptionChangeCommand(params:INotice):void {
			(this.action as MapEditerAction).changeOptions(params.data);
		}
		
		public function mapOptionUpdateCommand(notice:EditerOptionChangeNotice):void {
			
		}
	}

}