package game.data {
	import game.action.BattleAIAction;
	import game.command.BattleDataCommand;
	import game.model.BattleCardModel;
	import game.model.GeneralModel;
	import game.model.PositionsModel;
	import game.model.SkillModel;
	import game.notice.AddBattleCardToViewNotice;
	import game.notice.AddBattleWordNotice;
	import game.notice.BattleAINotice;
	import game.notice.BattleCardDataNotice;
	import game.notice.BattleDataNotice;
	import game.notice.BattleViewNotice;
	import game.utils.GetBattleGeneralType;
	import game.utils.SkillType;
	import game.view.battle.BattleSetting;
	import shipDock.framework.core.action.ActionController;
	
	import shipDock.framework.application.manager.LocaleManager;
	import shipDock.framework.core.interfaces.IDispose;
	import shipDock.framework.core.notice.InvokeProxyedNotice;
	import shipDock.framework.core.utils.HashMap;
	
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleAI extends EventDispatcher implements IDispose
	{
		
		//private var _action:BattleAIAction;
		private var _skillCreateMap:HashMap;
		
		private var _battleViewNotice:BattleViewNotice;
		private var _battleDataNotice:BattleDataNotice;
		private var _battleCardDataNotice:BattleCardDataNotice;
		private var _addBattleWordNotice:AddBattleWordNotice;
		private var _addBattleCardNotice:AddBattleCardToViewNotice;
		
		public function BattleAI() 
		{
			super();
			
			this._skillCreateMap = new HashMap();
			//this._action = new BattleAIAction();
			//this._action.setProxyed(this);
			
		}
		
		public function dispose():void {
			//this._action.dispose();
			
			this._skillCreateMap.clear();
		}
		
		public function runAI(notice:InvokeProxyedNotice):void {
			var dataNotice:BattleAINotice = notice.data;
		}
		
		public function createUserBattleCard(ownerType:int):void {
			var positionModel:PositionsModel = this.battleAIAction.getBattleGeneral(ownerType, GetBattleGeneralType.CURRENT);
			var list:Array = positionModel.positionsList;
			var i:int = 0;
			var max:int = list.length;
			
			var j:int = 0;
			var n:int = 0;
			var skillList:Array = [];
			var skillModel:SkillModel;
			var generalModel:GeneralModel;
			while (i < max) {
				if (list[i] != null) {
					generalModel = list[i];
					if (generalModel != null) {
						if ((generalModel.roleSkillIDs != null) && (generalModel.roleSkillIDs.length > 0)) {
							j = 0;
							n = generalModel.roleSkillIDs.length;
							while (j < n) {
								skillModel = new SkillModel(generalModel.roleSkillIDs[j], generalModel);
								skillList.push(skillModel);
								j++;
							}
						}
						if ((generalModel.battleSkillIDs != null) && (generalModel.battleSkillIDs.length > 0)) {
							j = 0;
							n = generalModel.battleSkillIDs.length;
							while (j < n) {
								skillModel = new SkillModel(generalModel.battleSkillIDs[j], generalModel);
								skillList.push(skillModel);
								j++;
							}
						}
					}
				}
				i++;
			}
			this.addNormalBattleCard(skillList);
			skillModel = skillList[int(skillList.length * Math.random())];
			
			var wordText:String = LocaleManager.getInstance().getText("battle_words_" + int(Math.random() * 6));
			var currentGenerals:Array = [];
			i = 0;
			max = list.length
			while (i < max) {
				if (list[i] != null) {
					currentGenerals.push(list[i]);
				}
				i++;
			}
			if (skillModel.skillType == SkillType.SKILL_TYPE_NORMAL) {
				generalModel = currentGenerals[int(currentGenerals.length * Math.random())];
				skillModel.setGeneralModel(generalModel);
			}
			this._skillCreateMap.put(generalModel, { "skill":skillModel, "ownerType":ownerType } );
			this.addBattleWordNotice.sendSelf(this.battleAIAction, null, [ownerType, skillModel.generalModel, wordText]);
			
		}
		
		public function battleAICreateBattleCard(notice:InvokeProxyedNotice):void {
			var dataNotice:BattleAINotice = notice.data;
			var generalModel:GeneralModel = dataNotice.data;
			var data:Object = this._skillCreateMap.getValue(generalModel);
			if (data == null) {
				return;
			}
			var skillModel:SkillModel = data["skill"];
			var ownerType:int = data["ownerType"];
			if (skillModel != null) {
				if (this._skillCreateMap.isContainsKey(generalModel)) {
					this._skillCreateMap.remove(generalModel);
				}
				var battleCardModel:BattleCardModel = new BattleCardModel(skillModel.id, ownerType, skillModel);
				this.battleCardDataNotice.sendSelf(this.battleAIAction, BattleDataCommand.ADD_BATTLE_CARD_COMMAND, [ownerType, -1, battleCardModel]);
				var count:int = this.battleCardDataNotice.sendSelf(this.battleAIAction, BattleDataCommand.GET_BATTLE_CARDS_COUNT_COMMAND, [ownerType]);
				if (count <= BattleSetting.BATTLE_CARD_MAX) {
					this.addBattleCardNotice.sendSelf(this.battleAIAction, null, [battleCardModel, count - 1]);
				}
			}
		}
		
		private function addNormalBattleCard(list:Array):void {
			var ids:Array = ["400004", "400005", "400006", "400007", "400008", "400009", "400010", "400011"];
			for each(var id:String in ids) {
				var skillModel:SkillModel = new SkillModel(id);
				list.push(skillModel);
			}
		}
		
		private function get battleViewNotice():BattleViewNotice {
			if (this._battleViewNotice == null) {
				this._battleViewNotice = new BattleViewNotice(null);
			}
			return this._battleViewNotice;
		}
		
		public function get addBattleWordNotice():AddBattleWordNotice 
		{
			if (this._addBattleWordNotice == null) {
				this._addBattleWordNotice = new AddBattleWordNotice(-1, null);
			}
			return _addBattleWordNotice;
		}
		
		public function get addBattleCardNotice():AddBattleCardToViewNotice 
		{
			if (this._addBattleCardNotice == null) {
				this._addBattleCardNotice = new AddBattleCardToViewNotice(null);
			}
			return _addBattleCardNotice;
		}
		
		public function get battleDataNotice():BattleDataNotice {
			if (this._battleDataNotice == null) {
				this._battleDataNotice = new BattleDataNotice(null);
			}
			return this._battleDataNotice;
		}
		
		public function get battleCardDataNotice():BattleCardDataNotice 
		{
			if (this._battleCardDataNotice == null) {
				this._battleCardDataNotice = new BattleCardDataNotice(0);
			}
			return _battleCardDataNotice;
		}
		
		private function get battleAIAction():BattleAIAction {
			return ActionController.getInstance().getAction(BattleAIAction.NAME) as BattleAIAction;
		}
	}
	

}