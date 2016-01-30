package command 
{
	import flash.events.Event;
	import flash.filesystem.File;
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
		
		override public function execute(notice:INotice):* 
		{
			var result:*;
			var file:File = notice.data;
			/*file.addEventListener(Event.COMPLETE, this.mapFileLoadComplete);
			file.load();*/
			var data:* = FileManager.getInstance().readFile(file, AssetType.TYPE_JSON);
			var a:* = data;
		}
		
		private function mapFileLoadComplete(event:Event):void {
			/*var file:File = event.target as File;
			FileManager.getInstance().readFile(file);
			file.data;*/
		}
	}

}