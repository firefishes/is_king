package game.command 
{
	import flash.geom.Point;
	import game.notice.NoticeName;
	
	import game.notice.AddBattleCardToViewNotice;
	import game.notice.AddBattleWordNotice;
	import game.notice.BattleDataNotice;
	import game.notice.BattleOptionPannelNotice;
	import game.notice.BattleViewNotice;
	import game.notice.CreateBattleGeneralNotice;
	import game.notice.LoadBattleAssetsNotice;
	import game.ui.BattleGeneral;
	import game.view.battle.BattleOpen;
	
	import shipDock.framework.application.loader.AssetType;
	import shipDock.framework.application.loader.FileAssetQueueLoader;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.queueExecuter.QueueExecuter;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattleViewCommand extends Command 
	{
		public static const INIT_BATTLE_VIEW_COMMAND:String = "initBattleViewCommand";
		public static const UPDATE_BATTLE_VIEW_COMMAND:String = "updateBattleViewCommand";
		public static const BATTLE_SKY_CHANGE_COMMAND:String = "battleSkyChangeCommand";
		public static const BATTLE_END_COMMAND:String = "battleEndCommand";
		
		public static const START_LOAD_BATTLE_ASSETS_COMMAND:String = "startLoadBattleAssetsCommand";
		public static const BATTLE_ASSETS_LOAD_COMPLETE_COMMAND:String = "battleAssetsLoadCompleteCommand";
		public static const CREATE_BATTLE_GENERAL_COMMAND:String = "createBattleGeneralCommand";
		public static const RUN_BATTLE_TICS_COMMAND:String = "runBattleTicsCommand";
		public static const STOP_BATTLE_TICS_COMMAND:String = "stopBattleTicsCommand";
		public static const GET_BATTLE_POS_BY_GRID_COMMAND:String = "getBattlePosByGridCommand";
		
		public static const MERGE_BATTLE_WORD_TEXT_COMMAND:String = "mergeBattleWordTextCommand";
		public static const COMMIT_BATTLE_VIEW_STATIC_TEXT_COMMAND:String = "commitBattleViewStaticTextCommand";
		
		public static const ADD_BATTLE_WORD_COMMAND:String = "addBattleWordCommand";
		public static const ADD_BATTLE_CARD_TO_VIEW_COMMAND:String = "addBattleCardToViewCommand";
		
		private var _battleDataNotice:BattleDataNotice;
		
		public function BattleViewCommand() 
		{
			super();
		}
		
		/**
		 * 开始加载战斗所需素材
		 * 
		 * @param	notice
		 */
		public function startLoadBattleAssetsCommand(notice:LoadBattleAssetsNotice):void {
			var queue:QueueExecuter = new QueueExecuter();
			var battleOpen:BattleOpen = this.getBattleOpen();
			var assetsPNG:FileAssetQueueLoader = new FileAssetQueueLoader(notice.assetsPNG, AssetType.TYPE_PNG);
			var assetsATF:FileAssetQueueLoader;
			if(notice.assetsATF != null) {
				assetsATF = new FileAssetQueueLoader(notice.assetsATF, AssetType.TYPE_ATF);
				queue.add(assetsATF);
			}
			queue.add(assetsPNG);
			queue.add(battleOpen);
			
			queue.commit();
		}
		
		private function getBattleOpen():BattleOpen {
			return this.action.callProxyed(NoticeName.GET_BATTLE_OPEN);
		}
		
		public function battleAssetsLoadCompleteCommand(notice:INotice):void {		
			this.action.callProxyed(NoticeName.ADD_BATTLE_BG, "demoBg");
			this.action.callProxyed(NoticeName.INIT_BATTLE_GENERAL);
			this.battleDataNotice.sendSelf(this, BattleDataCommand.START_BATTLE_COMMAND);
		}
		
		public function updateBattleViewOnFrameCommand(notice:INotice):void {
			this.action.callProxyed(NoticeName.UPDATE_BATTLE_VIEW_ON_FRAME, notice);
		}
		
		public function runBattleTicsCommand(notice:INotice):void {
			this.action.callProxyed(NoticeName.RUN_TIC, notice);
			this.action.callProxyed(NoticeName.CONTINUE_INELLINGENCE_BAR);
		}
		
		public function stopBattleTicsCommand(notice:INotice):void {
			this.action.callProxyed(NoticeName.STOP_TIC, notice);
			this.action.callProxyed(NoticeName.PAUSE_INELLINGENCE_BAR);
		}
		
		public function createBattleGeneralCommand(notice:CreateBattleGeneralNotice):BattleGeneral {
			var result:BattleGeneral = new BattleGeneral();
			result.data = notice.generalModel as Object;
			result.x = notice.initPos.x;
			result.y = notice.initPos.y;
			this.action.callProxyed(NoticeName.DISPLAY_BATTLE_GENERAL, result);
			return result;
		}
		
		public function getBattlePosByGridCommand(notice:BattleViewNotice):Point {
			return this.action.callProxyed(NoticeName.GET_BATTLE_POS_BY_GRID, notice);
		}
		
		public function initBattleViewCommand(notice:INotice):void {
			this.action.callProxyed(NoticeName.INIT_BATTLE_VIEW, notice);
		}
		
		public function mergeBattleWordTextCommand(notice:BattleViewNotice):void {
			this.action.callProxyed(NoticeName.MERGE_BATTLE_DIALOG_TEXT, notice.data);
		}
		
		public function commitBattleViewStaticTextCommand(notice:BattleViewNotice):void {
			this.action.callProxyed(NoticeName.UPDATE_BATTLE_VIEW_STATIC_TEXT);
		}
		
		public function addBattleWordCommand(notice:AddBattleWordNotice):void {
			this.action.callProxyed(NoticeName.ADD_BATTLE_WORD, notice);
		}
		
		public function addBattleCardToViewCommand(notice:AddBattleCardToViewNotice):void {
			this.action.callProxyed(NoticeName.ADD_BATTLE_CARD_TO_VIEW, notice);
		}
		
		public function get battleDataNotice():BattleDataNotice 
		{
			if (this._battleDataNotice == null) {
				this._battleDataNotice = new BattleDataNotice(null);
			}
			return _battleDataNotice;
		}
	}

}