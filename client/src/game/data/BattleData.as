package game.data
{
	import game.action.BattleAIAction;
	import game.command.BattleViewCommand;
	import game.model.BattleCardModel;
	import game.model.BattleDataPropertyModel;
	import game.model.BattleModel;
	import game.model.GeneralModel;
	import game.model.PositionsModel;
	import game.notice.BattleCardDataNotice;
	import game.notice.BattlePropertyChangedNotice;
	import game.notice.BattleViewNotice;
	import game.notice.GetBattleCardsNotice;
	import game.utils.BattleDataUtils;
	import game.utils.BattleOwner;
	import game.utils.BattlePropertyName;
	import game.utils.BattleSky;
	import game.utils.GeneralSiteName;
	import game.view.battle.BattleSetting;
	
	import shipDock.framework.application.SDCore;
	import shipDock.framework.core.observer.DataProxy;
	import shipDock.framework.core.utils.HashMap;
	import shipDock.framework.core.utils.SDUtils;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleData extends DataProxy
	{
		
		public static const BATTLE_DATA:String = "battleData";
		
		private var _battleModel:BattleModel;
		
		/**阵营属性列表**/
		private var _battlePropertyMap:HashMap;
		
		/**全体将领*/
		private var _userGeneralList:PositionsModel;
		private var _enemyGeneralList:PositionsModel;
		/**当前出动的将领*/
		private var _userCurrentGeneral:PositionsModel;
		private var _enemyCurrentGeneral:PositionsModel;
		/**已阵亡的将领*/
		private var _userDeadList:Array;
		private var _enemyDeadList:Array;
		/**我方战斗牌列表*/
		private var _userCardList:Array;
		/**敌方战斗牌列表*/
		private var _enemyCardList:Array;
		/**其他战斗牌列表，各种中立势力*/
		private var _neutralList:Array;
		/**战场时间*/
		private var _battleTime:uint;
		/**战场天色*/
		private var _battleSky:int;
		/**变天周期*/
		private var _skyChangeCycle:Number;
		
		private var _core:SDCore;
		private var _battleAI:BattleAI;
		
		public function BattleData()
		{
			super(BATTLE_DATA);
			this._core = SDCore.getInstance();
			this._userCardList = [];
			this._enemyCardList = [];
			this._battlePropertyMap = new HashMap();
			this._battleModel = new BattleModel();
		}
		
		/**
		 * 设置战场属性
		 * 
		 * @param	key
		 * @param	value
		 * @param	ownerType
		 */
		public function setBattleProperty(key:String, value:Number, ownerType:int = -1):void {
			var propertyModel:BattleDataPropertyModel;
			if(ownerType != -1) {
				propertyModel = this.getBattleDataPropertyModelByOwner(ownerType);
				propertyModel[key] = value;
			}else {
				propertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.USER_VALUE);
				propertyModel[key] = value;
				propertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.ENEMY_VALUE);
				propertyModel[key] = value;
			}
		}
		
		/**
		 * 获取战场属性
		 * 
		 * @param	key
		 * @param	ownerType
		 * @return
		 */
		public function getBattleProperty(key:String, ownerType:int = 0):Number {
			var result:Number;
			var propertyModel:BattleDataPropertyModel = this.getBattleDataPropertyModelByOwner(ownerType);
			(propertyModel != null) && (result = propertyModel[key]);
			return result;
		}
		
		/**
		 * 使用队伍的克隆初始化敌我将领队伍
		 * 
		 * @param	user
		 * @param	enemy
		 */
		public function initGenerals(user:Array, enemy:Array = null):void {
			this._userDeadList = [];
			this._enemyDeadList = [];
			
			this._userGeneralList = new PositionsModel("user");
			this._userGeneralList.setGeneralList(user);
			
			this._enemyGeneralList = new PositionsModel("enemy");
			if (enemy != null) {
				this._enemyGeneralList.setGeneralList(enemy);
			}else {
				this._enemyGeneralList.setGeneralList(this._battleModel.enemyList);
			}
			
			this._userCurrentGeneral = new PositionsModel("userCurrent");//最先出场的将领
			this._enemyCurrentGeneral = new PositionsModel("enemyCurrent");
			
			this._userCurrentGeneral.setGeneral(GeneralSiteName.L_PIONEER, this._userGeneralList.getGeneral(GeneralSiteName.L_PIONEER));
			this._userCurrentGeneral.setGeneral(GeneralSiteName.R_PIONEER, this._userGeneralList.getGeneral(GeneralSiteName.R_PIONEER));
			this._enemyCurrentGeneral.setGeneral(GeneralSiteName.L_PIONEER, this._enemyGeneralList.getGeneral(GeneralSiteName.L_PIONEER));
			this._enemyCurrentGeneral.setGeneral(GeneralSiteName.R_PIONEER, this._enemyGeneralList.getGeneral(GeneralSiteName.R_PIONEER));
		}
		
		/**
		 * 运行战场
		 * 
		 */
		public function startBattleData():void {
			this._core.frameRate = BattleSetting.BATTLE_FRAME_RATE;
			this._skyChangeCycle = BattleSetting.DAY_NIGHT_CHANGE_TIME_SECS * this._core.frameRate;
			this._battleSky = this._battleModel.startSky;
			
			this.initBattleProperty();//初始化战场属性
			this.battleStartBonus();
			
			this.sendNotice(new BattleViewNotice(BattleViewCommand.INIT_BATTLE_VIEW_COMMAND));
			
			//this.setChange("a", this._anger);
			//this.setChange("m", this._morale);
			//this.setChange("i", this._intelligence);
			//
			//this.notify(new BattleDataNotice(BattleViewCommand.UPDATE_BATTLE_VIEW_COMMAND, this.notifyData));
		}
		
		private function addCurrentGeneral(generalSiteName:int, ownerType:int = 0):void {
			var key:String = BattleOwner.OWNER_KEYS[ownerType];
			var list:PositionsModel = this[key + "GeneralList"];
			var current:PositionsModel = this[key + "CurrentGeneral"];
			var model:GeneralModel = list.getGeneral(generalSiteName);
			if (model != null) {
				current.setGeneral(generalSiteName, model);
			}
		}
		
		/**
		 * 初始化战场属性
		 * 
		 */
		private function initBattleProperty():void {
			
			this._battlePropertyMap.clear();
			this._battlePropertyMap.put(BattleOwner.USER_VALUE, new BattleDataPropertyModel(BattleOwner.USER_VALUE));
			this._battlePropertyMap.put(BattleOwner.ENEMY_VALUE, new BattleDataPropertyModel(BattleOwner.ENEMY_VALUE));
			
			SDUtils.wLoop(0, GeneralSiteName.SITE_MAX, this.setUserTroops);
			SDUtils.wLoop(0, GeneralSiteName.SITE_MAX, this.setEnemyTroops);
			
			this.setBattleProperty("anger", BattleSetting.ANGER_INIT);//初始化怒气
			this.setBattleProperty("angerChanged", 0);
			this.setBattleProperty("angerCycle", BattleSetting.ANGER_CYCLE_INIT);
			this.setBattleProperty("angerCycleCurrent", BattleSetting.ANGER_CYCLE_INIT);
			
			this.setBattleProperty("morale", BattleSetting.MORALE_INIT);//初始化士气
			this.setBattleProperty("moraleChanged", 0);
			this.setBattleProperty("moraleCycle", BattleSetting.MORALE_CYCLE_INIT);
			this.setBattleProperty("moraleCycleCurrent", BattleSetting.MORALE_CYCLE_INIT);
			
			this.setBattleProperty("intelligence", BattleSetting.INTELLIGENCE_INIT);//初始化情报，情报不做周期更新
			//this.setBattleProperty("intelligenceChanged", BattleSetting.INTELLIGENCE_CHANGED);
			//this.setBattleProperty("intelligenceCycle", BattleSetting.INTELLIGENCE_CYCLE_INIT);
			//this.setBattleProperty("intelligenceCycleCurrent", BattleSetting.INTELLIGENCE_CYCLE_INIT);
			
			this.setBattleProperty("moraleMax", BattleSetting.MORALE_MAX);//计算各属性最大值
			this.setBattleProperty("angerMax", BattleDataUtils.getBattleAngerMax(this._userGeneralList.positionsList), BattleOwner.USER_VALUE);
			this.setBattleProperty("angerMax", BattleDataUtils.getBattleAngerMax(this._enemyGeneralList.positionsList), BattleOwner.ENEMY_VALUE);
			this.setBattleProperty("intelligenceMax", BattleDataUtils.getBattleIntelligenceMax(this._userGeneralList.positionsList), BattleOwner.USER_VALUE);
			this.setBattleProperty("intelligenceMax", BattleDataUtils.getBattleIntelligenceMax(this._enemyGeneralList.positionsList), BattleOwner.ENEMY_VALUE);
		}
		
		/**
		 * 设置开局加成
		 * 
		 */
		private function battleStartBonus():void {
			
		}
		
		/**
		 * 初始化双方兵力
		 * 
		 * @param	index
		 */
		private function setUserTroops(index:int):void {
			var generalModel:GeneralModel = this._userGeneralList.getGeneral(index);
			if (generalModel != null) {
				var model:BattleDataPropertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.USER_VALUE);
				model.troops += generalModel.troops;
			}
		}
		
		private function setEnemyTroops(index:int):void {
			var generalModel:GeneralModel = this._enemyGeneralList.getGeneral(index);
			if (generalModel != null) {
				var model:BattleDataPropertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.ENEMY_VALUE);
				model.troops += generalModel.troops;
			}
		}
		
		/**
		 * 初始化双方怒气增长速度
		 * 
		 * @param	index
		 */
		private function setUserEngerSpeed(index:int):void {
			var generalModel:GeneralModel = this._userGeneralList.getGeneral(index);
			if (generalModel != null) {
			}
		}
		
		private function setEnemyEngerSpeed(index:int):void {
			var generalModel:GeneralModel = this._enemyGeneralList[index];
			if (generalModel != null) {
			}
		}
		
		/**
		 * 结束战场
		 * 
		 */
		public function endBattle():void {
			this.sendNotice(new BattleViewNotice(BattleViewCommand.STOP_BATTLE_TICS_COMMAND));
			this._core.frameRate = 60;
			this._battleModel = null;
		}
		
		/**
		 * 战场时间周期
		 * 
		 * @param	time
		 */
		public function updateDataOnFrame(time:Number):void {
			this.updateBattleProperty();
			this.updateBattle();
			this.checkBattleEnd();
		}
		
		/**
		 * 更新战场属性（所有阵营）
		 * 
		 */
		private function updateBattleProperty():void {
			this.setBattlePropertyOnUpdate(BattlePropertyName.ANGER);
			this.setBattlePropertyOnUpdate(BattlePropertyName.MORALE);
			this.setBattlePropertyOnUpdate(BattlePropertyName.INTELLIGENCE);
		}
		
		/**
		 * 设置战场属性的更新
		 * 
		 * @param	key
		 */
		private function setBattlePropertyOnUpdate(key:String):void {
			
//			var valueModel:BattleDataPropertyModel = this[key];
//			var changedModel:BattleDataPropertyModel = this[key + "Changed"];
//			var cycleModel:BattleDataPropertyModel = this[key + "Cycle"];
//			var currentCycleModel:BattleDataPropertyModel = this[key + "CycleCurrent"];
//			var maxModel:BattleDataPropertyModel = this[key + "Max"];
			var uDataModel:BattleDataPropertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.USER_VALUE);
			var eDataModel:BattleDataPropertyModel = this.getBattleDataPropertyModelByOwner(BattleOwner.ENEMY_VALUE);
//			var otherDataModel:BattleDataPropertyModel;//TODO 其他参战方的数据变化
			
			if (key == BattlePropertyName.INTELLIGENCE) {
				this.sendNotice(new BattlePropertyChangedNotice(key, uDataModel[key], uDataModel[key + "Changed"], uDataModel[key + "Max"], BattleOwner.USER_VALUE));
				return;//情报不做周期更新
			}
			uDataModel[key + "CycleCurrent"] += 1;//当前周期自增
			eDataModel[key + "CycleCurrent"] += 1;
			
			var cycleCurrent:Number = uDataModel[key + "CycleCurrent"];
			var cycleValue:Number = uDataModel[key + "Cycle"];
			
			if (cycleCurrent >= cycleValue) {//判断我方变化
				
				uDataModel[key + "CycleCurrent"] = cycleCurrent % cycleValue;
				uDataModel[key] += uDataModel[key + "Changed"];
				
				this.sendNotice(new BattlePropertyChangedNotice(key, uDataModel[key], uDataModel[key + "Changed"], uDataModel[key + "Max"], BattleOwner.USER_VALUE));
				
			}
			cycleCurrent = eDataModel[key + "CycleCurrent"];
			cycleValue = eDataModel[key + "Cycle"];
			if (cycleCurrent >= cycleValue) {//判断敌方变化
				
				eDataModel[key + "CycleCurrent"] = cycleCurrent % cycleValue;
				eDataModel[key] += eDataModel[key + "Changed"];
				
				this.sendNotice(new BattlePropertyChangedNotice(key, eDataModel[key], eDataModel[key + "Changed"], eDataModel[key + "Max"], BattleOwner.ENEMY_VALUE));
			}
		}
		
		/**
		 * 更新战场
		 * 
		 */
		private function updateBattle():void {
			this.updateBattleSky();
			this.updateSkill();
			
		}
		
		/**
		 * 更新战场天色
		 * 
		 */
		private function updateBattleSky():void {
			this._battleTime++;
			if (this._battleTime >= this._skyChangeCycle) {
				this._battleSky++;
				if (this._battleSky > BattleSky.SKY_END) {
					this._battleSky = BattleSky.SKY_START;
				}
				this._battleTime = this._skyChangeCycle % this._battleTime;//重置战场时间
				//this.setChange("battleSky", this._battleSky);
				this.notify(new BattleViewNotice(BattleViewCommand.BATTLE_SKY_CHANGE_COMMAND));//天色变换
			}
		}
		
		private function updateSkill():void {
			
		}
		
		/**
		 * 检测战斗是否结束
		 * 
		 */
		private function checkBattleEnd():void {
			var win:int = -1;
			var isUserAllDead:Boolean = (this._userDeadList.length > 0) && (this._userDeadList.length == this._userGeneralList.generalCount);
			var isEnemyAllDead:Boolean = (this._enemyDeadList.length > 0) && (this._enemyDeadList.length == this._enemyGeneralList.generalCount);
			if ((this.uTroops <= 0) || isUserAllDead)
				win = BattleOwner.ENEMY_VALUE;//敌方胜利
			else if ((this.eTroops <= 0) || isEnemyAllDead)
				win = BattleOwner.USER_VALUE;//我方胜利
			(win != -1) && this.notify(new BattleViewNotice(BattleViewCommand.BATTLE_END_COMMAND, win));
		}
		
		/**
		 * 将领是否阵亡
		 * 
		 * @param	ownerType
		 * @param	model
		 * @return
		 */
		public function isGeneralDead(ownerType:int, model:GeneralModel):Boolean {
			var list:Array;
			if(ownerType == BattleOwner.USER_VALUE) {
				list = this._userDeadList;
			}else if(ownerType == BattleOwner.ENEMY_VALUE) {
				list = this._enemyDeadList;
			}
			return (list.indexOf(model) != -1);
		}
		
		/**
		 * 情报属性蓄满
		 * 
		 * @param	ownerType
		 */
		public function intelligenceFillMax(ownerType:int):void {
			var max:Number = this.getBattleProperty(BattlePropertyName.INTELLIGENCE + "Max", ownerType);
			var current:Number = this.getBattleProperty(BattlePropertyName.INTELLIGENCE, ownerType);
			this.setBattleProperty(BattlePropertyName.INTELLIGENCE, current, ownerType);
			this.battleAI.createUserBattleCard(ownerType);
		}
		
		public function getBattleCardByIndex(notice:GetBattleCardsNotice):BattleCardModel {
			var result:BattleCardModel;
			var list:Array = (notice.ownerType == BattleOwner.USER_VALUE) ? this._userCardList : this._enemyCardList;
			this.sortCardList(list);
			result = list[notice.cardIndex];
			return result;
		}
		
		public function addBattleCard(notice:BattleCardDataNotice):void {
			var list:Array = (notice.ownerType == BattleOwner.USER_VALUE) ? this._userCardList : this._enemyCardList;
			this.sortCardList(list);
			if (notice.ownerType == BattleOwner.USER_VALUE) {
				this._userCardList = list;
			}else {
				
			}
			notice.cardModel.cardIndex = (list.length > 0) ? list.length - 1 : 0;
			list.push(notice.cardModel);
		}
		
		private function sortCardList(list:Array):void {
			var card:BattleCardModel;
			for each(card in list) {
				if (card == null) {
					list.splice(i, 1);
				}
			}
			var i:int = 0;
			var max:int = list.length;
			while (i < max) {
				card = list[i];
				if (card != null) {
					card.cardIndex = i;
				}
				i++;
			}
		}
		
		public function getBattleCardCount(notice:BattleCardDataNotice):uint {
			var list:Array = (notice.ownerType == BattleOwner.USER_VALUE) ? this._userCardList : this._enemyCardList;
			this.sortCardList(list);
			return (list != null) ? list.length : 0;
		}
		
		/**
		 * 根据参战方类型获取参展方战斗数据
		 *  
		 * @param battleOwner
		 * @return 
		 * 
		 */		
		private function getBattleDataPropertyModelByOwner(battleOwner:int):BattleDataPropertyModel {
			return this._battlePropertyMap.getValue(battleOwner);
		}
		
		/**
		 * 关卡数据模型
		 * 
		 */
		public function get battleModel():BattleModel 
		{
			return _battleModel;
		}
		
		public function set battleModel(value:BattleModel):void 
		{
			_battleModel = value;
		}
		
		/**
		 * 我方场上将领
		 * 
		 */
		public function get userCurrentGeneral():PositionsModel 
		{
			return _userCurrentGeneral;
		}
		
		/**
		 * 敌方场上将领
		 * 
		 */
		public function get enemyCurrentGeneral():PositionsModel 
		{
			return _enemyCurrentGeneral;
		}
		
		/**
		 * 战场时间，确定战场天色
		 * 
		 */
		public function get battleTime():uint 
		{
			return _battleTime;
		}
		
		/**
		 * 战场天色
		 * 
		 */
		public function get battleSky():int 
		{
			return _battleSky;
		}
		
		public function get uTroops():Number {
			return this.getBattleProperty(BattlePropertyName.TROOPS, BattleOwner.USER_VALUE);
		}
		
		public function get eTroops():Number {
			return this.getBattleProperty(BattlePropertyName.TROOPS, BattleOwner.ENEMY_VALUE);
		}
		
		public function get battleAI():BattleAI {
			if(!this._battleAI) {
				var ac:BattleAIAction = this.getAction(BattleAIAction.NAME) as BattleAIAction;
				this._battleAI = ac.battleAI;
			}
			return this._battleAI;
		}

	}

}