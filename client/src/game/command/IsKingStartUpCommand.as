package game.command 
{
	import game.action.BattleAIAction;
	import game.action.BattleCardIconAction;
	import game.action.BattleOptionPannelActoin;
	import game.action.BattleViewAction;
	import game.data.BattleData;
	import game.data.CampData;
	import game.data.ProfileData;
	import game.notice.NoticeName;
	import shipDock.framework.core.command.SDStartUpCommand;
	
	import shipDock.framework.core.action.ActionController;
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.command.CoreCommand;
	import shipDock.framework.core.command.UICommand;
	import shipDock.framework.core.interfaces.INotice;
	import shipDock.framework.core.notice.CoreNotice;
	import shipDock.framework.core.notice.Notice;
	import shipDock.framework.core.notice.SDUINotice;
	
	/**
	 * 初始化所有需要预添加的命令类、数据代理对象、逻辑代理对象
	 * 
	 * ...
	 * @author ch.ji
	 */
	public class IsKingStartUpCommand extends SDStartUpCommand 
	{
		
		public function IsKingStartUpCommand() 
		{
			super();
			
		}
		
		override protected function get proxyList():Array {
			return super.proxyList.concat([ProfileData, CampData, BattleData]);
		}
		
		override protected function get actionList():Array {
			return super.actionList.concat([BattleViewAction, BattleCardIconAction, BattleOptionPannelActoin, BattleAIAction]);
		}
		
		override protected function get commandList():Array 
		{
			return super.commandList.concat([
				[NoticeName.BATTLE_VIEW, BattleViewCommand],
				[NoticeName.BATTLE_DATA, BattleDataCommand],
				[NoticeName.BATTLE_OPTION_PANNEL, BattleOptionPannelCommand],
			]);
		}
	}

}