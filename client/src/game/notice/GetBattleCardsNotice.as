package game.notice 
{
	import game.command.BattleDataCommand;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GetBattleCardsNotice extends BattleCardDataNotice 
	{
		
		public function GetBattleCardsNotice(ownerType:int, cardIndex:int = -1) 
		{
			super(ownerType, cardIndex);
			this.subCommand = BattleDataCommand.GET_BATTLE_CARDS_COMMAND;
		}
		
	}

}