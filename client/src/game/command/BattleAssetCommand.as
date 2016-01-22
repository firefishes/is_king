package game.command 
{
	import game.action.BattleInitGeneralShowAction;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * 战斗素材命令类
	 * 
	 * ...
	 * @author ch.ji
	 */
	public class BattleAssetCommand extends Command 
	{
		
		public static const ADD_BATTLE_PRELOAD_ASSET_COMMAND:String = "addBattlePreloadAssetCommand";
		
		public function BattleAssetCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		public function addBattlePreloadAssetCommand(notice:INotice):void {
			(this.action as BattleInitGeneralShowAction).addAsset(notice.data);
		}
		
	}

}