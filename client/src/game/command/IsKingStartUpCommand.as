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
	public class IsKingStartUpCommand extends Command 
	{
		
		public function IsKingStartUpCommand() 
		{
			super(false);
			
		}
		
		override public function execute(notice:INotice):* 
		{
			this.initCommands();
			this.initProxies();
			this.initActions();
		}
		
		private function initCommands():void {
			
			var list:Array = [
				NoticeName.BATTLE_VIEW, BattleViewCommand,
				NoticeName.BATTLE_DATA, BattleDataCommand,
				NoticeName.BATTLE_OPTION_PANNEL, BattleOptionPannelCommand,
			];
			
			var i:int = 0, cls:Class, name:String;
			var max:int = list.length;
			var actionController:ActionController = ActionController.getInstance();
			while (i < max) {
				name = list[i];
				cls = list[i + 1];
				actionController.preregisteredCommand(name, cls);
				i += 2;
			}
		}
		
		private function initProxies():void {
			var notice:CoreNotice = new CoreNotice(CoreCommand.REGISTERED_PROXYIES_COMMAND, this.proxyList);
			this.sendNotice(notice);
		}
		
		private function initActions():void {
			var notice:CoreNotice = new CoreNotice(CoreCommand.REGISTERED_ACTION_COMMAND, this.actionList);
			this.sendNotice(notice);
		}
		
		private function get proxyList():Array {
			return [ProfileData, CampData, BattleData];
		}
		
		private function get actionList():Array {
			return [BattleViewAction, BattleCardIconAction, BattleOptionPannelActoin, BattleAIAction];
		}
	}

}