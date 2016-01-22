package game.loader 
{
	import game.GameSetting;
	import game.notice.ChooseServerNotice;
	import game.notice.GameVersionNotice;
	import game.utils.ResourceListType;
	import shipDock.framework.core.manager.NoticeManager;
	import shipDock.framework.core.model.SyncModel;
	import shipDock.loader.VersionLoader;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameVersion extends VersionLoader 
	{
		private var _dataIndex:int = 0;
		
		public function GameVersion() 
		{
			var urlValue:String = GameSetting.asset + GameSetting.FILE_CONFIG + "resource.json";
			super(urlValue, null, null);
			
		}
		
		override public function commit():void 
		{
			switch(GameSetting.resourceListType) {
				case ResourceListType.RESOURCE_LIST_TYPE_FILE://加载资源目录文件方式获取资源列表
					super.commit();
					break;
				case ResourceListType.RESOURCE_LIST_TYPE_API://服务端接口方式获取资源列表
					var gameVersionNotice:GameVersionNotice = new GameVersionNotice(this.getVersionCallback);
					NoticeManager.sendNotice(gameVersionNotice);
					break;
			}
		}
		
		override protected function getVersionData(resultData:Object):Object 
		{
			var result:Object;
			switch(GameSetting.resourceListType) {
				case ResourceListType.RESOURCE_LIST_TYPE_FILE://加载资源目录文件方式获取资源列表
					result = resultData["resouce"];
					break;
				case ResourceListType.RESOURCE_LIST_TYPE_API://服务端接口方式获取资源列表
					result = resultData["data"]["data"]["assets"];
					break;
			}
			return result;
		}
		
		override protected function setAssetVersion(key:String, data:Object):void 
		{
			var item:Object = data[key];
			var syncModel:SyncModel;
			var fileVersionKey:String;
			switch(GameSetting.resourceListType) {
				case ResourceListType.RESOURCE_LIST_TYPE_FILE://加载资源目录文件方式获取资源列表
					
					super.setAssetVersion(key, data);
					
					break;
				case ResourceListType.RESOURCE_LIST_TYPE_API://服务端接口方式获取资源列表
					//TODO api下添加版本数据项
					this.addAssetVersion(fileVersionKey, syncModel);
					break;
			}
		}
	}

}