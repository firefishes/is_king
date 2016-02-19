package command 
{
	import shipDock.framework.core.command.Command;
	import shipDock.framework.core.interfaces.INotice;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class NewMapCommand extends Command 
	{
		
		public function NewMapCommand(isAutoExecute:Boolean=true) 
		{
			super(isAutoExecute);
			
		}
		
		override public function execute(notice:INotice):* 
		{
			var result:* = super.execute(notice);
			
			return result;
		}
	}

}