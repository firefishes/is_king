package game.action 
{
	import game.command.IsKingStartUpCommand;
	import shipDock.framework.application.manager.ViewManager;
	
	import shipDock.framework.core.action.SDAction;
	import shipDock.framework.core.command.UICommand;
	import shipDock.framework.core.notice.SDNoticeName;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class MainAction extends SDAction 
	{
		
		public function MainAction() 
		{
			super(IsKingStartUpCommand);
		}
		
		public function startView():void {
			ViewManager.getInstance().changeView(BattleViewAction.NAME);
		}
	}

}