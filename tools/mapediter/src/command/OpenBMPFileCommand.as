package command 
{
	import data.MapData;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import notice.OpenBMPNotice;
	import shipDock.framework.application.loader.AssetType;
	import shipDock.framework.application.loader.DisplayAssetLoader;
	import shipDock.framework.application.manager.FileManager;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class OpenBMPFileCommand extends Command 
	{
		
		public static const IMPORT_FOR_SYMBOL_COMMAND:String = "importForSymbolCommand";
		
		public function OpenBMPFileCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function importForSymbolCommand(params:INotice):void {
			var theNotice:OpenBMPNotice = params as OpenBMPNotice;
			var file:File = (theNotice) ? theNotice.file : params.data;
			var bytes:ByteArray = FileManager.getInstance().readFile(file, AssetType.TYPE_PNG);
			var loader:DisplayAssetLoader = new DisplayAssetLoader(bytes, this.loadComplete);
			loader.isAutoDispose = true;
			loader.load();
			
			if (theNotice) {
				
				var mapData:MapData = DataProxy.getDataProxy(MapData.NAME);
				//var wFile:File = FileManager.
				FileManager.getInstance().writeBytes(mapData.getNewSymbolPath(theNotice.fileName), bytes);
				trace("s");
				//mapData.addSymbol(file.url);
			}
		}
		
		private function loadComplete(result:*):void {
			trace(result);
		}
		
	}

}