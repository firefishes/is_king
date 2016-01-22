package game.notice 
{
	import game.net.ServerMethod;
	import shipDock.framework.core.notice.HTTPNotice;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameVersionNotice extends HTTPNotice 
	{
		
		public function GameVersionNotice(doSuccess:Function=null, doFail:Function=null) 
		{
			//this.isFalseData = true;
			super(ServerMethod.RET_INDEX, {}, doSuccess, doFail);
			
		}
		
		override public function successed(result:Object):void 
		{
			if (this.isFalseData) {
				var list:Array = [];
				var assets:Array = result["data"]["data"]["assets"] as Array;
				assets = assets.concat(list);
			}
			super.successed(result);
		}
		
	}

}