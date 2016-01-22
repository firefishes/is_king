package game.action 
{
	import flash.geom.Point;
	
	import game.command.BattleAssetCommand;
	import game.command.BattleViewCommand;
	import game.model.GeneralModel;
	import game.notice.BattleViewNotice;
	import game.notice.CreateBattleGeneralNotice;
	import game.notice.NoticeName;
	import game.ui.BattleGeneral;
	import game.utils.BattleOwner;
	import game.view.battle.BattleSetting;
	import game.view.battle.battleInit.BattleInitGeneralShow;
	
	import shipDock.framework.application.SDConfig;
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.loader.FileAssetQueueLoader;
	import shipDock.framework.core.action.Action;
	import shipDock.framework.core.methodExecuter.MethodElement;
	import shipDock.framework.core.utils.SDUtils;
	import shipDock.framework.core.utils.gc.reclaimArray;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleInitGeneralShowAction extends Action 
	{
		
		public static const NAME:String = "battleInitGeneralShowAction";
		
		private var _battleAssetNames:Array;
		private var _enemyList:Array;
		private var _userList:Array;
		private var _uGenerals:Array;
		private var _eGenerals:Array;
		
		public function BattleInitGeneralShowAction(userList:Array, enemyList:Array) 
		{
			super();
			this._battleAssetNames = [];
			this._userList = userList;
			this._enemyList = enemyList;
			this._uGenerals = [];
			this._eGenerals = [];
		}
		
		override public function dispose():void {
			super.dispose();
			reclaimArray(this._uGenerals);
			reclaimArray(this._eGenerals);
			this._userList = null;
			this._enemyList = null;
		}
		
		override protected function setCommand():void 
		{
			super.setCommand();
			
			this.registered(NoticeName.BATTLE_ASSETS, BattleAssetCommand);
		}
		
		public function addAsset(source:*):void {
			if (source is String)
				this._battleAssetNames.push(source);
			else if (source is Array)
				this._battleAssetNames = this._battleAssetNames.concat(source);
		}
		
		public function startLoadBattleGeneralAsset():void {
			this._battleAssetNames.push("battleCard");//卡牌素材
			var complete:MethodElement = new MethodElement(this.loadAssetListComplete);
			SDCore.getInstance().loaderManager.load(this._battleAssetNames, "battle", complete, null, FileAssetQueueLoader, [null]);
		}
		
		private function loadAssetListComplete(event:*):void {
			SDUtils.forEach(this._uGenerals, this.generalBattleUpdate);
			SDUtils.forEach(this._eGenerals, this.generalBattleUpdate);
			(this.battleInitGeneralShow) && this.battleInitGeneralShow.batttleGeneralAssetListLoaded();
		}
		
		private function generalBattleUpdate(value:Object):void {
			var target:BattleGeneral = value["target"];
			(target) && target.updateGeneralImage();
		}
		
		public function setBattleGeneralShow(battleOwner:int):Array
		{
			var isUser:Boolean = (battleOwner == BattleOwner.USER_VALUE);
			var result:Array = (isUser) ? this._uGenerals : this._eGenerals;
			var list:Array = (isUser) ? this._userList : this._enemyList;
			
			var index:int, point:Point, initPoint:Point, general:GeneralModel, battleGeneral:BattleGeneral, notice:BattleViewNotice, initX:Number;
			for each (general in list)
			{
				if (general != null)
				{
					index = list.indexOf(general);
					point = BattleSetting.getBattleGeneralSite(index, isUser);
					notice = new BattleViewNotice(BattleViewCommand.GET_BATTLE_POS_BY_GRID_COMMAND, {"row": point.y, "column": point.x});
					point = this.sendNotice(notice);
					
					initX = (isUser) ? (point.x - 100) : (SDConfig.stageWidth + 100);
					initPoint = new Point(initX, point.y);
					battleGeneral = this.sendNotice(new CreateBattleGeneralNotice(general, initPoint, battleOwner));
					
					result.push({"target":battleGeneral, "x":point.x});
				}
			}
			return result;
		}
		
		private function get battleInitGeneralShow():BattleInitGeneralShow {
			return this.proxyed as BattleInitGeneralShow;
		}
	}

}