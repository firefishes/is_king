package notice 
{
	import flash.filesystem.File;
	import shipDock.framework.core.interfaces.IObserver;
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class OpenBMPNotice extends Notice 
	{
		
		public function OpenBMPNotice(forWhat:int, fileName:String, file:File = null, observer:IObserver=null, autoDispose:Boolean=true) 
		{
			super(NoticeName.OPEN_BMP_FILE, {"forWhat":forWhat, "fileName":fileName, "file":file}, observer, autoDispose);
			
		}
		
		public function get forWhat():int {
			return this.data["forWhat"];
		}
		
		public function get fileName():String {
			return this.data["fileName"];
		}
		
		public function get file():File {
			return this.data["file"];
		}
	}

}