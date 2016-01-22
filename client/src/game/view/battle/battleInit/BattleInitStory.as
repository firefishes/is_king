package game.view.battle.battleInit 
{
	import shipDock.framework.core.interfaces.IQueueExecuter;
	import shipDock.framework.core.queueExecuter.QueueExecuterEvent;
	import starling.events.EventDispatcher;
	
	/**
	 * 战斗开场剧情
	 * 
	 * TODO 
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleInitStory extends EventDispatcher implements IQueueExecuter 
	{
		
		public function BattleInitStory() 
		{
			
		}
		
		public function dispose():void {
			
		}
		
		/* INTERFACE shipDock.interfaces.IQueueExecuter */
		
		public function commit():void 
		{
			this.queueNext();
		}
		
		/**
		 * 执行此对象所在队列的下一个队列元素
		 *
		 */
		public function queueNext():void
		{
			this.dispatchEventWith(QueueExecuterEvent.QUEUE_UNIT_NEXT_EVENT);
		}
		
		public function get queueSize():uint {
			return 1;
		}
		
		public function get eventDispatcher():EventDispatcher {
			return this as EventDispatcher;
		}
	}

}