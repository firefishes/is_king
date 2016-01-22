package game.loader 
{
	import game.notice.GameInitNotice;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.queueExecuter.QueueExecuterEvent;
	import shipDock.loader.Preloader;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameInitLoader extends Preloader 
	{
		
		public function GameInitLoader(complete:Function=null, progress:Function=null) 
		{
			super(null, complete, progress);
			
		}
		
		override public function commit():void 
		{
			super.commit();
		}
		
		override protected function createPreloaderNotice():INotice 
		{
			return new GameInitNotice(this.gameInitCallback);
		}
		
		private function gameInitCallback(result:Object):void {
			this.dispatchEvent(new QueueExecuterEvent(QueueExecuterEvent.QUEUE_UNIT_NEXT_EVENT));
		}
		
	}

}