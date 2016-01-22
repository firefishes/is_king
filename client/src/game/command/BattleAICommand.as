package game.command 
{
	import game.action.BattleAIAction;
	import game.notice.BattleAINotice;
	import game.notice.NoticeName;
	import shipDock.framework.core.command.Command;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleAICommand extends Command 
	{
		
		public static const RUN_AI_COMMAND:String = "runAICommand";
		public static const BATTLE_AI_CREATE_BATTLE_CARD_COMMAND:String = "battleAIcreateCardBattleCommand";
		
		public function BattleAICommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function runAICommand(notice:BattleAINotice):void {
			this.action.callProxyed(NoticeName.RUN_AI, notice);
		}
		
		public function battleAIcreateCardBattleCommand(notice:BattleAINotice):void {
			this.action.callProxyed(NoticeName.BATTLE_AI_CREATE_BATTLE_CARD, notice);
		}
	}

}