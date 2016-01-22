package game.view.battle 
{
	import game.command.BattleViewCommand;
	import game.notice.BattleViewNotice;
	import shipDock.framework.core.manager.NoticeManager;
	
	import shipDock.framework.application.component.SDComponent;
	import shipDock.framework.core.interfaces.IQueueExecuter;
	import shipDock.framework.core.queueExecuter.QueueExecuterEvent;
	
	import starling.animation.IAnimatable;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleOpen extends SDComponent implements IQueueExecuter,IAnimatable
	{
		
		public function BattleOpen() 
		{
			super();
			
		}
		
		/* INTERFACE shipDock.interfaces.IQueueExecuter */
		
		public function commit():void 
		{
			this.movieStart();
		}
		
		/**
		 * 执行此对象所在队列的下一个队列元素
		 *
		 */
		public function queueNext():void
		{
			this.dispatchEventWith(QueueExecuterEvent.QUEUE_UNIT_NEXT_EVENT);
		}
		
		private function movieStart():void {
			this.movieEnd();
		}
		
		private function movieEnd():void {
			NoticeManager.sendNotice(new BattleViewNotice(BattleViewCommand.BATTLE_ASSETS_LOAD_COMPLETE_COMMAND));
			this.queueNext();
			this.dispose();
		}
		
		public function advanceTime(time:Number):void {
			
		}
		
		public function get queueSize():uint {
			return 1;
		}
		
		public function get eventDispatcher():EventDispatcher {
			return this as EventDispatcher;
		}
	}

}