package game.notice 
{
	import game.command.BattleViewCommand;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class LoadBattleAssetsNotice extends BattleViewNotice 
	{
		
		public function LoadBattleAssetsNotice(assetsPNG:Array, assetsATF:Array = null) 
		{
			super(BattleViewCommand.START_LOAD_BATTLE_ASSETS_COMMAND, {"assetsPNG":assetsPNG, "assetsATF":assetsATF});
			
		}
		
		public function get assetsPNG():Array {
			return this.data["assetsPNG"];
		}
		
		public function get assetsATF():Array {
			return this.data["assetsATF"];
		}
	}

}