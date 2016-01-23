package game.action 
{
	import game.command.BattleDataCommand;
	import game.command.BattleOptionPannelCommand;
	import game.notice.BattleCardDataNotice;
	import game.notice.BattleOptionPannelNotice;
	import game.view.battle.BattleSetting;
	import shipDock.framework.core.action.Action;
	
	import shipDock.framework.core.action.SDViewActoin;
	
	/**
	 * 战斗公共逻辑代理
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleCardIconAction extends Action
	{
		
		private var _battleCardDataNotice:BattleCardDataNotice;
		private var _battleOptionPannelNotice:BattleOptionPannelNotice;
		
		public function BattleCardIconAction(name:String=null) 
		{
			super(name);
			
		}
		
		override protected function setCommand():void 
		{
			super.setCommand();
		}
		
		public function refillInellingence(ownerType:int):void {
			var count:int = this.battleCardDataNotice.sendSelf(this, BattleDataCommand.GET_BATTLE_CARDS_COUNT_COMMAND, [ownerType]);
			if (count < BattleSetting.BATTLE_CARD_MAX) {
				this.battleOptionPannelNotice.sendSelf(this, BattleOptionPannelCommand.REFILL_INELLINGENCE_BAR_COMMAND);
			}
		}
		
		public function get battleCardDataNotice():BattleCardDataNotice 
		{
			if (this._battleCardDataNotice == null) {
				this._battleCardDataNotice = new BattleCardDataNotice(0);
			}
			return _battleCardDataNotice;
		}
		
		public function get battleOptionPannelNotice():BattleOptionPannelNotice 
		{
			if (this._battleOptionPannelNotice == null) {
				this._battleOptionPannelNotice = new BattleOptionPannelNotice(null);
			}
			return _battleOptionPannelNotice;
		}

	}

}