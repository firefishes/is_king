package notice 
{
	import shipDock.framework.core.interfaces.IObserver;
	import shipDock.framework.core.notice.Notice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class EditerOptionChangeNotice extends Notice 
	{
		
		public function EditerOptionChangeNotice(option:int, observer:IObserver=null, autoDispose:Boolean=true) 
		{
			super(NoticeName.MAP_EDITER, {"option":option}, observer, autoDispose);
			
		}
		
		public function get currentOption():int {
			return this.data["option"];
		}
	}

}