package game.loader 
{
	import game.net.ServerMethod;
	import game.notice.ChooseServerNotice;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.loader.Preloader;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameChooseServer extends Preloader 
	{
		
		public function GameChooseServer(complete:Function=null, progress:Function=null) 
		{
			super(null, complete, progress);
			
		}
		
		override protected function createPreloaderNotice():INotice 
		{
			return new ChooseServerNotice(this.HTTPNoticeSuccess);
		}
		
		override protected function HTTPNoticeSuccess(result:Object):void 
		{
			super.HTTPNoticeSuccess(result);
			this.queueNext();
			this.dispose();
		}
	}

}