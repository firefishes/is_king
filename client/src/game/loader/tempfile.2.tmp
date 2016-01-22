package game.loader
{
	import game.GameSetting;
	
	import shipDock.framework.application.loader.FileLoader;
	import shipDock.framework.application.loader.FileSyncer;
	import shipDock.framework.application.manager.VersionManager;
	import shipDock.framework.core.command.ShareObjectCommand;
	import shipDock.framework.core.manager.LogsManager;
	import shipDock.framework.core.manager.NoticeManager;
	import shipDock.framework.core.model.SyncModel;
	import shipDock.framework.core.notice.ShareObjectNotice;
	import shipDock.framework.core.utils.SDUtils;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameFileSyncer extends FileSyncer
	{
		
		public function GameFileSyncer(complete:Function = null, progress:Function = null)
		{
			super(null, null, complete, progress);
		
		}
		
		override public function checkFileVersion():void
		{
			this._waitingList = [];
			var assetVersion:Object = VersionManager.getAssetVersion(); //获取当前的文件版本
			SDUtils.forIn(assetVersion, this.setWaitngListItem);
		}
		
		private function setWaitngListItem(key:String, target:Object):void
		{
			var syncItem:SyncModel = target[key];
			if ((syncItem != null) && this.checkIsNeedLoad(syncItem))
			{
				this._waitingList.push(syncItem); //将需要加载的增量文件的同步数据加入等待队列
				this._waitingData[syncItem.name] = syncItem;
				
				LogsManager.getInstance().setLog("【GAME FILE SYNC】File " + syncItem.name + " needs sync.");
			}
		}
		
		/**
		 * 与文件的上一次版本作比对，确认是否需要加载
		 *
		 * @param	item
		 * @return
		 */
		override protected function checkIsNeedLoad(item:*):Boolean
		{
			var syncItem:SyncModel = item as SyncModel;
			var notice:ShareObjectNotice = new ShareObjectNotice(ShareObjectCommand.GET_FILE_VERSION_CHECKER_SO_COMMAND, GameSetting.GAME_OS_NAME, "localFileVersion");
			var localFileVersion:Object = NoticeManager.sendNotice(notice);
			var name:String = (syncItem != null) ? syncItem.name : null;
			return VersionManager.isAssetOverdue(name, "verifyID", localFileVersion[name]); //通过生成同步文件数据对象时的名称提取数据对象，并和里面的验证码比对
		}
		
		override protected function disposeFileLoader(target:FileLoader):void
		{
			super.disposeFileLoader(target);
			if (target == null)
			{
				return;
			}
			var notice:ShareObjectNotice = new ShareObjectNotice(ShareObjectCommand.GET_FILE_VERSION_CHECKER_SO_COMMAND, GameSetting.GAME_OS_NAME, "localFileVersion");
			var localFileVersion:Object = NoticeManager.sendNotice(notice);
			var key:String = target.name;
			var syncModel:SyncModel = this._waitingData[key];
			localFileVersion[key] = syncModel.verifyID; //使用当前的验证号覆盖本地验证号
			
			notice = new ShareObjectNotice(ShareObjectCommand.FLUSH_SO_COMMAND, GameSetting.GAME_OS_NAME, "localFileVersion", localFileVersion);
			NoticeManager.sendNotice(notice);
			
			LogsManager.getInstance().setLog("【GAME FILE SYNC】File " + target.name + " is synced. sync index is " + this._queue.currentIndex);
		}
		
		override protected function getFilePath(index:int):String
		{
			return (this.waitingList[index] as SyncModel).filePath;
		}
		
		override protected function getFileURL(index:int):String
		{
			return (this.waitingList[index] as SyncModel).fileURL;
		}
		
		override protected function getFileLoaderName(index:int):String
		{
			return (this.waitingList[index] as SyncModel).name;
		}
	}

}