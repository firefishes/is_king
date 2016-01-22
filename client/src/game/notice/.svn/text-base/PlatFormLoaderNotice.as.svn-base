package game.notice
{
	import game.GameSetting;
	import game.model.GameProfile;
	import game.net.ServerMethod;
	import shipDock.data.IProfileProxy;
	import shipDock.data.ProfileProxy;
	import shipDock.framework.core.notice.HTTPNotice;
	import shipDock.framework.core.observer.DataProxy;
	
	/**
	 * 获取平台参数消息
	 *
	 * ...
	 * @author shaoxin.ji
	 */
	public class PlatFormLoaderNotice extends HTTPNotice
	{
		
		public function PlatFormLoaderNotice(doSuccess:Function)
		{
			super(ServerMethod.USER_PLATFORM_ACCESS, {"platform": GameSetting.PLATFORM}, doSuccess);
			this.isFalseData = true;
		}
		
		override public function successed(result:Object):void
		{
			if (this.isFalseData)
			{
				result = {"data": {"sign": "demo_sign"}};
			}
			var userProfile:IProfileProxy = DataProxy.getDataProxy(ProfileProxy.PROXY_NAME);
			userProfile.setSign(result["data"]["sign"]);
			super.successed(result);
		}
	}

}