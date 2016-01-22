package game.notice 
{
	import game.net.ServerMethod;
	
	import shipDock.framework.core.notice.HTTPNotice;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleFightNotice extends HTTPNotice 
	{
		
		public function BattleFightNotice(battleID:String, isPVE:Boolean, doSuccess:Function=null, doFail:Function=null) 
		{
			this.isFalseData = true;
			
			this.sendNotice(new InitBattleNotice(this.battleID));//初始化战斗结果数据，包括备份我方将领阵容
			
			super(ServerMethod.BATTLE_FIGHT, {"battle_id":battleID, "is_pve":isPVE}, doSuccess, doFail);
			
		}
		
		override public function successed(result:Object):void 
		{
			super.successed(result);
			
			//TODO 准备战斗数据
			
			var list:Array = ["demoBg", "img_100001"];
			
			this.sendNotice(new LoadBattleAssetsNotice(list));
		}
		
		public function get battleID():String {
			return this.data["battle_id"];
		}
	}

}