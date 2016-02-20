package notice 
{
	import command.NewMapCommand;
	import shipDock.framework.core.interfaces.IObserver;
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class CreateNewMapNotice extends Notice 
	{
		
		public function CreateNewMapNotice(name:String, cnName:String, cellColumn:uint, cellRow:uint, bgImagePath:String) 
		{
			super(NoticeName.NEW_MAP_FILE, {"n":name, "cn":cnName, "cc":cellColumn, "cr":cellRow, "bg":bgImagePath});
			this.subCommand = NewMapCommand.CREATE_NEW_MAP_COMMAND;
		}
		
		public function get mapName():String {
			return this.data["n"];
		}
		
		public function get cnName():String {
			return this.data["cn"];
		}
		
		public function get cellColumn():uint {
			return this.data["cc"];
		}
		
		public function get cellRow():uint {
			return this.data["cr"];
		}
		
		public function get bgImagePath():String {
			return this.data["bg"];
		}
	}

}