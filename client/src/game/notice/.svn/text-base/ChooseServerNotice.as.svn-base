package game.notice
{
	import game.model.GameProfile;
	import game.net.ServerMethod;
	import shipDock.data.IProfileProxy;
	import shipDock.data.ProfileProxy;
	import shipDock.framework.core.notice.HTTPNotice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class ChooseServerNotice extends HTTPNotice
	{
		
		public function ChooseServerNotice(doSuccess:Function = null, doFail:Function = null)
		{
			super(ServerMethod.GAME_SERVERS, {}, doSuccess, doFail);
			this.isFalseData = true;
		
		}
		
		override public function successed(result:Object):void
		{
			if (this.isFalseData) {
				result = {"data":{"servers":{"last":{"id":0}}}};
			}
			var serverData:Object = result["data"]["servers"];
			var lastServerData:Object = serverData["last"] || serverData["servers"][0];
			var userProfile:IProfileProxy = DataProxy.getDataProxy(ProfileProxy.PROXY_NAME);
			userProfile.setServerID(lastServerData["id"]);
			super.successed(result);
		}
	
	}

}