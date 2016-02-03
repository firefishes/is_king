package game.command 
{
	import shipDock.framework.core.command.Command;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class BattleElementsCommand extends Command 
	{
		
		public static const ADD_MAP_GRID_COMMAND:String = "addMapGridCommand";
		
		public function BattleElementsCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
	}

}