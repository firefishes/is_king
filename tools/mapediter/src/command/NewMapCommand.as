package command 
{
	import flash.filesystem.File;
	import notice.CreateNewMapNotice;
	import notice.NoticeName;
	import shipDock.framework.application.loader.AssetType;
	import shipDock.framework.application.manager.FileManager;
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
		
		public function createNewMapCommand(notice:INotice/*CreateNewMapNotice*/):void 
		{
			var manager:FileManager = FileManager.getInstance();
			var result:Object = manager.readFile(new File(manager.appFile.nativePath + "map_temp.ikmap"), AssetType.TYPE_JSON);
			this.sendNotice(NoticeName.MAP_DATA, result, MapDataCommand.SET_MAP_COMMAND);
			this.sendNotice(NoticeName.MAP_DATA, notice, MapDataCommand.SET_MAP_INFO_COMMAND);
		}
	}

}