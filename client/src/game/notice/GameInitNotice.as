package game.notice 
{
	import game.data.CampData;
	import game.model.GameProfile;
	import game.model.GeneralModel;
	import game.net.ServerMethod;
	import shipDock.framework.core.notice.HTTPNotice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameInitNotice extends HTTPNotice 
	{
		
		public function GameInitNotice(doSuccess:Function=null, doFail:Function=null) 
		{
			this.isFalseData = true;
			super(ServerMethod.GAME_INIT, null, doSuccess, doFail);
			
		}
		
		override public function successed(result:Object):void 
		{
			super.successed(result);
			
			result = { };
			
			var campList:Array = [
				new GeneralModel("100001"),
				new GeneralModel("100002"),
				new GeneralModel("100003"),
				new GeneralModel("100004"),
				new GeneralModel("100005"),
				new GeneralModel("100006"),
				new GeneralModel("100007"),
				new GeneralModel("100008"),
			];
			var campData:CampData = DataProxy.getDataProxy(CampData.CAMP_DATA);
			campData.updateCampByServer(campList);
		}
		
	}

}