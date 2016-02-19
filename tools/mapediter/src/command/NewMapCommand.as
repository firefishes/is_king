package command 
{
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class NewMapCommand extends Command 
	{
		
		public static const POPUP_CREATE_PANNEL_COMMAND:String = "popupCreatePannelCommand";
		public static const CREATE_NEW_MAP_COMMAND:String = "createNewMapCommand";
		
		public function NewMapCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function createNewMapCommand(notice:INotice):void 
		{
			trace(notice.data);
		}
	}

}