package game.command 
{
	import game.action.BattleOptionPannelActoin;
	import game.notice.NoticeName;
	import game.utils.BattleOwner;
	import game.notice.BattleOptionPannelNotice;
	import game.notice.BattlePropertyChangedNotice;
	import shipDock.framework.core.command.Command;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleOptionPannelCommand extends Command 
	{
		
		public static const COMMIT_BATTLE_VALUE_TEXT_COMMAND:String = "commitBattleValueTextCommand";
		public static const BATTLE_PROPERTY_CHANGED_COMMAND:String = "battlePropertyChangedCommand";
		public static const REFILL_INELLINGENCE_BAR_COMMAND:String = "refillInellingenceBarCommand";
		
		public function BattleOptionPannelCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function battlePropertyChangedCommand(notice:BattlePropertyChangedNotice):void {
			if(notice.ownerType == BattleOwner.USER_VALUE) {
				this.battleOptionPannelAction.setBattlePropertyText(notice);
			}
		}
		
		public function commitBattleValueTextCommand(notice:BattleOptionPannelNotice):void {
			this.battleOptionPannelAction.callProxyed(NoticeName.BATTLE_OP_PANNEL_COMMIT_STATIC_TEXTS, notice);
		}
		
		public function refillInellingenceBarCommand(notice:BattleOptionPannelNotice):void {
			this.battleOptionPannelAction.callProxyed(NoticeName.RESTART_INELLINGENCE_BAR, notice);
		}
		
		private function get battleOptionPannelAction():BattleOptionPannelActoin {
			return this.action as BattleOptionPannelActoin;
		}
		
	}

}