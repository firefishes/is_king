package game.view.battle 
{
	import flash.geom.Point;
	import game.notice.NoticeName;
	
	import game.action.BattleOptionPannelActoin;
	import game.action.BattleViewAction;
	import game.model.GeneralModel;
	import game.model.SkillModel;
	import game.notice.AddBattleCardToViewNotice;
	import game.notice.AddBattleWordNotice;
	import game.notice.BattleOptionPannelNotice;
	import game.notice.BattleViewNotice;
	import game.ui.BattleCardIcon;
	import game.ui.BattleGeneral;
	import game.ui.BattleWords;
	import game.utils.BattleOwner;
	import game.view.battle.battleInit.BattleInitGeneralShow;
	import game.view.battle.battleInit.BattleInitStory;
	import game.view.events.BattleCardEvent;
	
	import shipDock.framework.application.SDConfig;
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.SDJuggler;
	import shipDock.framework.application.component.SDComponent;
	import shipDock.framework.application.component.SDImage;
	import shipDock.framework.application.component.SDQuadText;
	import shipDock.framework.application.component.SDSprite;
	import shipDock.framework.application.manager.ConfigManager;
	import shipDock.framework.core.command.UICommand;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.notice.InvokeProxyedNotice;
	import shipDock.framework.core.notice.SDNoticeName;
	import shipDock.framework.core.queueExecuter.QueueExecuter;
	import shipDock.framework.core.utils.HashMap;
	import shipDock.framework.core.utils.gc.reclaim;
	import shipDock.ui.View;
	import shipDock.ui.ViewChildQueueUnit;
	
	import starling.animation.IAnimatable;
	import starling.display.DisplayObject;
	
	/**
	 * 战场界面
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleView extends View implements IAnimatable
	{
		
		private var _battleGridLayer:BattleGridLayer;
		private var _generalList:Array;//场上的将领列表
		
		private var _bgLayer:SDSprite;
		private var _generalLayer:SDSprite;//将领层
		private var _effectLayer:SDSprite;
		
		private var _battleContainer:SDSprite;
		private var _battleJuggler:SDJuggler;
		private var _core:SDCore;
		private var _lastTime:Number;
		private var _viewChildQueue:QueueExecuter;
		
		public function BattleView() 
		{
			super();
			this._UIConfigName = "battleView";
		}
		
		override protected function disposeAction():void {
			this.battleViewAction.sendNotice(SDNoticeName.SD_UI, BattleOptionPannelActoin.NAME, UICommand.CLOSE_VIEW_COMMAND);
			super.disposeAction();
		}
		
		override protected function disposeView():void 
		{
			super.disposeView();
			this._core.juggler.remove(this._battleJuggler);
			reclaim(this._viewChildQueue);
			this._viewChildQueue = null;
			this._battleJuggler = null;
		}
		
		override protected function initViewTexture():void 
		{
			super.initViewTexture();
			
			this._viewTextures = [["battleView"], []];
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			this._core = SDCore.getInstance();
			this._battleJuggler = new SDJuggler();
			this._core.juggler.add(this._battleJuggler);
			
			this._viewChildQueue = new QueueExecuter();
			
			this.createView();
			this.createBattleOptionPannel();
			
			this._viewChildQueue.add(this.createViewEnd);
			this._viewChildQueue.start();
			
			var troop:Object = ConfigManager.getInstance().getConfig("troop");
			for (var k:* in troop) {
				trace(troop[k]["atk"]);
			}
		}
		
		private function createView():void {
			
			var battleLayer:SDSprite = this.getEmptySpriteUI("gridLayer");
			this._battleGridLayer = new BattleGridLayer(battleLayer.x, battleLayer.y, 5, 12, 936, 435);
			
			var battleOpen:BattleOpen = new BattleOpen();
			battleOpen.name = "battleOpen";
			this.putChildraw(battleOpen);
			
			this._bgLayer = new SDSprite();
			this._generalLayer = new SDSprite();
			this._effectLayer = new SDSprite();
			
			this._battleContainer = new SDSprite();
			this._battleContainer.addChild(this._bgLayer);
			this._battleContainer.addChild(this._generalLayer);
			this._battleContainer.addChild(this._effectLayer);
			
			this.addChildAt(this._battleContainer, 0);
		}
		
		private function createBattleOptionPannel():void {
			
			this.battleViewAction.sendNotice(SDNoticeName.SD_UI, BattleOptionPannelActoin.NAME, UICommand.OPEN_VIEW_COMMAND);
			var pannel:BattleOptionPannel = this.battleViewAction.sendNotice(NoticeName.GET_BATTLE_OPTION_PANNEL);
			this.putChildraw(pannel as DisplayObject, "optionPannel");
			
			var p:SDSprite = this.getEmptySpriteUI("generalOptionPannel");
			this._viewChildQueue.add(new ViewChildQueueUnit(pannel as SDComponent, p));
		}
		
		private function createViewEnd():void {
			this.battleViewAction.sendBattleRequest();
		}
		
		public function addBattleBg(notice:INotice):void {
			var name:String = notice.data;
			var bg:SDImage = SDCore.getInstance().assetManager.getImage(name);
			this._bgLayer.addChild(bg);
		}
		
		public function initBattleGeneral(notice:InvokeProxyedNotice):void {
			this._generalList = [];
		}
		
		public function updateBattleViewOnFrame(notice:InvokeProxyedNotice):void {
			this._generalList.sortOn("y", Array.NUMERIC);
		}
		
		public function initBattleView(notice:InvokeProxyedNotice):void {
			
			var dataNotice:BattleViewNotice = notice.data;
			var userList:Array = this.battleViewAction.getCurrentGeneral(BattleOwner.USER_VALUE).positionsList;
			var enemyList:Array = this.battleViewAction.getCurrentGeneral(BattleOwner.ENEMY_VALUE).positionsList;
			
			var queue:QueueExecuter = new QueueExecuter();
			//初始化各属性槽、出场将领、对话
			queue.add(new BattleInitStory());
			queue.add(new BattleInitGeneralShow(userList, enemyList));
			queue.add(this.battleViewInited);
			queue.commit();
		}
		
		/**
		 * 正式开始战斗
		 * 
		 */
		private function battleViewInited():void {
			this._lastTime = 0;
			this.battleViewAction.runBattleAI();
			this.battleViewAction.runBattleTics();
		}
		
		public function runTic(notice:InvokeProxyedNotice):void {
			var dataNotice:BattleViewNotice = notice.data;
			this._battleJuggler.add(this);
		}
		
		public function stopTic(notice:InvokeProxyedNotice):void {
			var dataNotice:BattleViewNotice = notice.data;
			this._battleJuggler.remove(this);
		}
		
		public function displayBattleGeneral(notice:InvokeProxyedNotice):void {
			var result:BattleGeneral = notice.data;
			this._generalList.push(result);
			this._generalLayer.addChild(result);
		}
		
		public function getBattlePosByGrid(notice:InvokeProxyedNotice):Point {
			var dataNotice:BattleViewNotice = notice.data;
			return this._battleGridLayer.getPosByGrid(dataNotice.data["row"], dataNotice.data["column"]);
		}
		
		/**
		 * 战场时间周期
		 * 
		 * @param	time
		 */
		public function advanceTime(time:Number):void {
			this._lastTime += time;
			if (this._lastTime >= 1 / this._core.frameRate) {
				
				this.battleViewAction.updateDataOnFrame(time);
				
				this._lastTime = 0;
			}
		}
		
		override public function redraw():void 
		{
			super.redraw();
			if (this.isPropertySet("updateBattleViewStaticText", true)) {
				this.commitStaticTextsChanged();
			}
		}
		
		public function mergeBattleDialogText(notice:InvokeProxyedNotice):void {
			var target:SDQuadText = notice.data as SDQuadText;
			this.addStaticQuadBatchText(target);
		}
		
		public function addBattleWord(notice:InvokeProxyedNotice):void {
			var dataNotice:AddBattleWordNotice = notice.data;
			var battleGeneral:BattleGeneral;
			for each(battleGeneral in this._generalList) {
				if (battleGeneral.generalModel.id == dataNotice.genralModel.id) {
					break;
				}
			}
			var battleWordsMap:HashMap = this.getPropertyChanged("battleWordsMap") as HashMap;
			if (battleWordsMap == null) {
				battleWordsMap = new HashMap();
			}
			battleWordsMap.put(dataNotice.genralModel, battleGeneral);
			this.changeProperty("battleWordsMap", battleWordsMap);
			
			var battleWords:BattleWords = new BattleWords(dataNotice.wordText, dataNotice.genralModel);
			battleWords.x = battleGeneral.x + battleGeneral.width / 2 * SDConfig.globalScale;
			battleWords.y = battleGeneral.y - battleGeneral.height * 2;// / 2 * SDConfig.globalScale;
			this.addChild(battleWords);
		}
		
		public function addBattleCardToView(notice:InvokeProxyedNotice):void {
			var dataNotice:AddBattleCardToViewNotice = notice.data as AddBattleCardToViewNotice;
			var battleWordsMap:HashMap = this.getPropertyChanged("battleWordsMap") as HashMap;
			if (battleWordsMap != null) {
				var skillModel:SkillModel = dataNotice.skillModel;
				var generalModel:GeneralModel = skillModel.generalModel;
				var targetPos:Point = this.battleViewAction.callProxyed(NoticeName.GET_BATTLE_CARD_TARGET_POS, dataNotice);
				var battleCardIcon:BattleCardIcon = new BattleCardIcon();
				battleCardIcon.data = {"battleCardModel":dataNotice.battleCardModel, "targetPos":targetPos, "ownerType":dataNotice.ownerType };
				var battleGeneral:BattleGeneral = battleWordsMap.getValue(generalModel, true) as BattleGeneral;
				battleCardIcon.x = battleGeneral.x - battleGeneral.width / 2;
				battleCardIcon.y = battleGeneral.y - battleGeneral.height / 2;
				this.addChild(battleCardIcon);
				
				battleCardIcon.dispatchEvent(new BattleCardEvent(BattleCardEvent.BATTLE_CARD_ICON_READY_EVENT, battleCardIcon));
			}
		}
		
		public function updateBattleViewStaticText(notice:InvokeProxyedNotice):void {
			this.changePropertySet("updateBattleViewStaticText", true);
			this.invalidate();
		}
		
		public function getBattleOpen(notice:InvokeProxyedNotice):BattleOpen {
			return this.getChildraw("battleOpen") as BattleOpen;
		}
		
		override public function commitStaticTextsChanged():void 
		{
			super.commitStaticTextsChanged();
		}
		
		private function get battleViewAction():BattleViewAction {
			return this.action as BattleViewAction;
		}
		
		private function get optionPannel():BattleOptionPannel {
			return this.getChildraw("optionPannel") as BattleOptionPannel;
		}

	}

}