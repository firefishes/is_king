package game.view.battle.battleInit
{
	import game.action.BattleInitGeneralShowAction;
	import game.ui.BattleGeneral;
	import game.utils.BattleOwner;
	
	import shipDock.framework.application.effect.AnimatableEffect;
	import shipDock.framework.application.effect.ParallelEffect;
	import shipDock.framework.core.interfaces.IQueueExecuter;
	import shipDock.framework.core.queueExecuter.QueueExecuter;
	import shipDock.framework.core.queueExecuter.QueueExecuterEvent;
	import shipDock.framework.core.utils.SDUtils;
	import shipDock.framework.core.utils.gc.reclaim;
	
	import starling.events.EventDispatcher;
	
	/**
	 * 战斗将领出场
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleInitGeneralShow extends EventDispatcher implements IQueueExecuter
	{
		
		private var _generalCount:int;
		
		private var _queue:QueueExecuter;
		private var _parallel:ParallelEffect;
		private var _action:BattleInitGeneralShowAction;
		
		public function BattleInitGeneralShow(userList:Array, enemyList:Array)
		{
			super();
			this._action = new BattleInitGeneralShowAction(userList, enemyList);
			this._generalCount = 0;
			
			this._queue = new QueueExecuter();
			this._action.setProxyed(this);
		}
		
		public function dispose():void
		{
			reclaim(this._queue);
			reclaim(this._action);
		}
		
		/* INTERFACE shipDock.interfaces.IQueueExecuter */
		
		public function commit():void
		{
			var list:Array;
			this._parallel = new ParallelEffect();
			list = this._action.setBattleGeneralShow(BattleOwner.USER_VALUE);
			SDUtils.forEach(list, this.createAnimate);
			list = this._action.setBattleGeneralShow(BattleOwner.ENEMY_VALUE);
			SDUtils.forEach(list, this.createAnimate);
			this._queue.add(_parallel);
			this._queue.add(this.showComplete);
			this._action.startLoadBattleGeneralAsset();
		}
		
		private function createAnimate(value:Object):void {
			if (!value)
				return;
			var battleGeneral:BattleGeneral = value["target"];
			var animate:AnimatableEffect = new AnimatableEffect(battleGeneral, 0.3, {"x": value["x"]});
			this._parallel.effectList.push(animate);
		}
		
		/**
		 * 执行此对象所在队列的下一个队列元素
		 *
		 */
		public function queueNext():void
		{
			this.dispatchEventWith(QueueExecuterEvent.QUEUE_UNIT_NEXT_EVENT);
		}
		
		public function batttleGeneralAssetListLoaded():void
		{
			this._queue.commit();
		}
		
		
		private function showComplete():void
		{
			this.queueNext();
		}
		
		public function get queueSize():uint {
			return 1;
		}
		
		public function get eventDispatcher():EventDispatcher {
			return this as EventDispatcher;
		}
	
	}

}