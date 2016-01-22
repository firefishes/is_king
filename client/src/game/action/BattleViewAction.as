package game.action 
{
	import game.command.BattleAICommand;
	import game.command.BattleDataCommand;
	import game.command.BattleOptionPannelCommand;
	import game.command.BattleViewCommand;
	import game.model.PositionsModel;
	import game.notice.BattleAINotice;
	import game.notice.BattleDataNotice;
	import game.notice.BattleFightNotice;
	import game.notice.BattleGeneralPositionsNotice;
	import game.notice.BattleViewNotice;
	import game.notice.NoticeName;
	import game.utils.DataName;
	import game.view.battle.BattleView;
	
	import shipDock.data.ProfileProxy;
	import shipDock.framework.core.action.SDViewActoin;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.notice.InvokeProxyedNotice;
	
	/**
	 * 战斗主界面逻辑代理
	 * 
	 * ...
	 * @author ...
	 */
	public class BattleViewAction extends SDViewActoin 
	{
		
		public static const NAME:String = "battleViewAction";
		
		private var _battleViewNotice:BattleViewNotice;
		private var _battleDataNotice:BattleDataNotice;
		
		public function BattleViewAction() 
		{
			super(NAME, BattleView);
			
			this.bindDataProxy(ProfileProxy.PROXY_NAME);//观察用户数据变更
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			this.unbindDataProxy(ProfileProxy.PROXY_NAME);//注销用户数据变更的观察
		}
		
		override protected function get preregisteredCommand():Array 
		{
			return super.preregisteredCommand.concat([
				NoticeName.BATTLE_VIEW,
				NoticeName.BATTLE_DATA,
			]);
		}
		
		override protected function initViewAction():void {
			super.initViewAction();
			if(this.battleView) {
				this.addNotice(NoticeName.INIT_BATTLE_VIEW, this.battleView.initBattleView);
				this.addNotice(NoticeName.GET_BATTLE_POS_BY_GRID, this.battleView.getBattlePosByGrid);
				this.addNotice(NoticeName.ADD_BATTLE_BG, this.battleView.addBattleBg);
				this.addNotice(NoticeName.RUN_TIC, this.battleView.runTic);
				this.addNotice(NoticeName.STOP_TIC, this.battleView.stopTic);
				this.addNotice(NoticeName.UPDATE_BATTLE_VIEW_ON_FRAME, this.battleView.updateBattleViewOnFrame);
				this.addNotice(NoticeName.ADD_BATTLE_CARD_TO_VIEW, this.battleView.addBattleCardToView);
				this.addNotice(NoticeName.ADD_BATTLE_WORD, this.battleView.addBattleWord);
				this.addNotice(NoticeName.UPDATE_BATTLE_VIEW_STATIC_TEXT, this.battleView.updateBattleViewStaticText);
				this.addNotice(NoticeName.MERGE_BATTLE_DIALOG_TEXT, this.battleView.mergeBattleDialogText);
				this.addNotice(NoticeName.DISPLAY_BATTLE_GENERAL, this.battleView.displayBattleGeneral);
				this.addNotice(NoticeName.GET_BATTLE_OPEN, this.battleView.getBattleOpen);
				this.addNotice(NoticeName.INIT_BATTLE_GENERAL, this.battleView.initBattleGeneral);
			}
		}
		
		override protected function resetViewAction():void {
			super.resetViewAction();
			this.removeNotice(NoticeName.INIT_BATTLE_VIEW, this.battleView.initBattleView);
			this.removeNotice(NoticeName.GET_BATTLE_POS_BY_GRID, this.battleView.getBattlePosByGrid);
			this.removeNotice(NoticeName.ADD_BATTLE_BG, this.battleView.addBattleBg);
			this.removeNotice(NoticeName.RUN_TIC, this.battleView.runTic);
			this.removeNotice(NoticeName.STOP_TIC, this.battleView.stopTic);
			this.removeNotice(NoticeName.UPDATE_BATTLE_VIEW_ON_FRAME, this.battleView.updateBattleViewOnFrame);
			this.removeNotice(NoticeName.ADD_BATTLE_CARD_TO_VIEW, this.battleView.addBattleCardToView);
			this.removeNotice(NoticeName.ADD_BATTLE_WORD, this.battleView.addBattleWord);
			this.removeNotice(NoticeName.UPDATE_BATTLE_VIEW_STATIC_TEXT, this.battleView.updateBattleViewStaticText);
			this.removeNotice(NoticeName.MERGE_BATTLE_DIALOG_TEXT, this.battleView.mergeBattleDialogText);
			this.removeNotice(NoticeName.DISPLAY_BATTLE_GENERAL, this.battleView.displayBattleGeneral);
			this.removeNotice(NoticeName.GET_BATTLE_OPEN, this.battleView.getBattleOpen);
			this.removeNotice(NoticeName.INIT_BATTLE_GENERAL, this.battleView.initBattleGeneral);
		}
		
		public function sendBattleRequest():void {
			this.sendNotice(new BattleFightNotice("b001", true));//发送战斗的服务端请求
		}
		
		public function runBattleTics():void {
			this.battleViewNotice.sendSelf(this, BattleViewCommand.RUN_BATTLE_TICS_COMMAND);
		}
		
		public function runBattleAI():void {
			this.sendNotice(new BattleAINotice(BattleAICommand.RUN_AI_COMMAND));
		}
		
		public function stopBattleTics():void {
			this.battleViewNotice.sendSelf(this, BattleViewCommand.STOP_BATTLE_TICS_COMMAND);
		}
		
		public function updateDataOnFrame(time:Number):void {
			this.battleDataNotice.sendSelf(this, BattleDataCommand.UPDATE_BATTLE_DATA_ON_FRAME_COMMAND, [time]);
		}
		
		public function getCurrentGeneral(owner:int):PositionsModel {
			var result:PositionsModel = this.sendNotice(new BattleGeneralPositionsNotice(BattleDataCommand.GET_CURRENT_GENERAL_LIST_COMMAND, owner));
			return result;
		}
		
		override public function notify(notice:INotice):* 
		{
			var name:String = notice.name;
			if (name == DataName.BATTLE_DATA_SUBJECT) {
				var subCommand:String = notice.subCommand;
				if (subCommand == BattleViewCommand.UPDATE_BATTLE_VIEW_COMMAND) {
					//this.sendNotice(new BattleViewNotice(subCommand, notice);
					
				}else if (subCommand == BattleViewCommand.BATTLE_SKY_CHANGE_COMMAND) {
					
				}else if (subCommand == BattleOptionPannelCommand.BATTLE_PROPERTY_CHANGED_COMMAND) {
					
				}else if (subCommand == BattleViewCommand.BATTLE_END_COMMAND) {
					this.callProxyed(NoticeName.STOP_TIC);
				}
			}
			return null;
		}
		
		public function get battleViewNotice():BattleViewNotice 
		{
			(this._battleViewNotice == null) && (this._battleViewNotice = new BattleViewNotice(null));
			return _battleViewNotice;
		}
		
		public function get battleDataNotice():BattleDataNotice 
		{
			(this._battleDataNotice == null) && (this._battleDataNotice = new BattleDataNotice(null));
			return _battleDataNotice;
		}
		
		private function get battleView():BattleView {
			return this.view as BattleView;
		}
	}

}