package game.action 
{
	import game.notice.BattleOptionPannelNotice;
	import game.notice.BattlePropertyChangedNotice;
	import game.notice.BattlePropertyFillNotice;
	import game.notice.NoticeName;
	import game.utils.BattlePropertyName;
	import game.view.battle.BattleOptionPannel;
	import shipDock.framework.core.interfaces.INotice;
	
	import shipDock.framework.core.action.SDViewActoin;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleOptionPannelActoin extends SDViewActoin 
	{
		
		public static const NAME:String = "battleOptionPannelAction";
		
		public function BattleOptionPannelActoin() 
		{
			super(NAME, BattleOptionPannel);
			
		}
		
		override protected function get preregisteredCommand():Array 
		{
			return super.preregisteredCommand.concat([
				NoticeName.BATTLE_OPTION_PANNEL,
			]);
		}
		
		override protected function initViewAction():void {
			super.initViewAction();
			if(this.battleOptionPannel) {
				this.addNotice(NoticeName.RESTART_INELLINGENCE_BAR, this.battleOptionPannel.restartInellingenceBar);
				this.addNotice(NoticeName.BATTLE_OP_PANNEL_COMMIT_STATIC_TEXTS, this.battleOptionPannel.commitStaticTexts);
				this.addNotice(NoticeName.GET_BATTLE_CARD_TARGET_POS, this.battleOptionPannel.getBattleCardTargetPos);
				this.addNotice(NoticeName.PAUSE_INELLINGENCE_BAR, this.battleOptionPannel.pauseIntelligenceBar);
				this.addNotice(NoticeName.CONTINUE_INELLINGENCE_BAR, this.battleOptionPannel.continueIntelligenceBar);
				this.addNotice(NoticeName.GET_BATTLE_OPTION_PANNEL, this.getBattleOptionPannel);
			}
		}
		
		override protected function resetViewAction():void {
			super.resetViewAction();
			if(this.battleOptionPannel) {
				this.removeNotice(NoticeName.RESTART_INELLINGENCE_BAR, this.battleOptionPannel.restartInellingenceBar);
				this.removeNotice(NoticeName.BATTLE_OP_PANNEL_COMMIT_STATIC_TEXTS, this.battleOptionPannel.commitStaticTexts);
				this.removeNotice(NoticeName.GET_BATTLE_CARD_TARGET_POS, this.battleOptionPannel.getBattleCardTargetPos);
				this.removeNotice(NoticeName.PAUSE_INELLINGENCE_BAR, this.battleOptionPannel.pauseIntelligenceBar);
				this.removeNotice(NoticeName.CONTINUE_INELLINGENCE_BAR, this.battleOptionPannel.continueIntelligenceBar);
				this.removeNotice(NoticeName.GET_BATTLE_OPTION_PANNEL, this.getBattleOptionPannel);
			}
		}
		
		public function setBattlePropertyText(notice:BattlePropertyChangedNotice):void {
			this.battleOptionPannel.setBattlePropertyText(notice.propertyName, notice.propertyValue, notice.propertyMax);
		}
		
		/**
		 * 情报槽蓄满
		 * 
		 */
		public function intelligenceMax(ownerType:int):void {
			this.sendNotice(new BattlePropertyFillNotice(ownerType, BattlePropertyName.INTELLIGENCE, true));
		}
		
		private function getBattleOptionPannel(notice:INotice):BattleOptionPannel {
			return this.battleOptionPannel;
		}
		
		private function get battleOptionPannel():BattleOptionPannel {
			return this.view as BattleOptionPannel;
		}
	}

}