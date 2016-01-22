package game.action 
{
	import game.command.BattleAICommand;
	import game.data.BattleAI;
	import game.notice.BattleAINotice;
	import game.notice.NoticeName;
	import game.model.PositionsModel;
	import game.notice.GetBattleGeneralNotice;
	import shipDock.framework.core.action.Action;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleAIAction extends Action 
	{
		
		public static const NAME:String = "battleAIAction";
		
		private var _getBattleGeneralNotice:GetBattleGeneralNotice;
		
		public function BattleAIAction() 
		{
			super(NAME);
			
			this.setProxyed(new BattleAI());
		}
		
		override public function dispose():void 
		{
			
		}
		
		override protected function setCommand():void 
		{
			super.setCommand();
			
			this.registered(NoticeName.BATTLE_AI, BattleAICommand);
		}
		
		override protected function initNotices():void 
		{
			super.initNotices();
			if (this.battleAI) {
				this.addNotice(NoticeName.BATTLE_AI_CREATE_BATTLE_CARD, this.battleAI.battleAICreateBattleCard);
				this.addNotice(NoticeName.RUN_AI, this.battleAI.runAI);
			}
		}
		
		override protected function cleanNotices():void 
		{
			super.cleanNotices();
			if (this.battleAI) {
				this.removeNotice(NoticeName.BATTLE_AI_CREATE_BATTLE_CARD, this.battleAI.battleAICreateBattleCard);
				this.removeNotice(NoticeName.RUN_AI, this.battleAI.runAI);
			}
		}
		
		/**
		 * 获取某一方的战场将领
		 * 
		 * @param	ownerType
		 * @param	battleGeneralType 取值范围：GetBattleGeneralType 里的值
		 * @return
		 */
		public function getBattleGeneral(ownerType:int, battleGeneralType:int):PositionsModel {
			return this.getBattleGeneralNotice.sendSelf(this, null, [ownerType, battleGeneralType]);
		}
		
		public function get getBattleGeneralNotice():GetBattleGeneralNotice 
		{
			if (this._getBattleGeneralNotice == null) {
				this._getBattleGeneralNotice = new GetBattleGeneralNotice(0, 0);
			}
			return _getBattleGeneralNotice;
		}
		
		public function get battleAI():BattleAI {
			return this.proxyed as BattleAI;
		}
	}

}