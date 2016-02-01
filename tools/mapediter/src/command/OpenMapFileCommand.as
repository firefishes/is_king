package command 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import notice.NoticeName;
	import shipDock.framework.application.loader.AssetType;
	import shipDock.framework.application.manager.FileManager;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class OpenMapFileCommand extends Command 
	{
		
		public function OpenMapFileCommand() 
		{
			super(false);
			
		}
		
		override public function execute(params:INotice):* 
		{
			var result:*;
			var file:File = params.data;
			var data:* = FileManager.getInstance().readFile(file, AssetType.TYPE_JSON);
			this.sendNotice(NoticeName.MAP_DATA, data, MapDataCommand.SET_MAP_COMMAND);
		}
	}

}