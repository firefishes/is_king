package command 
{
	import data.MapData;
	import notice.NoticeName;
	import shipDock.framework.core.action.ActionController;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.command.SDStartUpCommand;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerStartUpCommand extends SDStartUpCommand 
	{
		
		public function MapEditerStartUpCommand() 
		{
			super();
			
		}
		
		override protected function get commandList():Array 
		{
			return super.commandList.concat([
				[NoticeName.NEW_MAP_FILE, NewMapCommand],
				[NoticeName.OPEN_MAP_FILE, OpenMapFileCommand],
				[NoticeName.OPEN_BMP_FILE, OpenBMPFileCommand],
				[NoticeName.MAP_DATA, MapDataCommand],
				[NoticeName.MAP_EDITER, MapEditerCommand],
			]);
		}
		
		override protected function get proxyList():Array 
		{
			return super.proxyList.concat([MapData]);
		}
		
	}

}