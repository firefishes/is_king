package  
{
	import game.action.MainAction;
	import game.loader.GameChooseServer;
	import game.loader.GameFileSyncer;
	import game.loader.GameInitLoader;
	import game.loader.GamePlatformLoader;
	import game.loader.GameVersion;
	import game.view.battle.BattleView;
	
	import shipDock.framework.application.Application;
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.loader.AssetType;
	import shipDock.framework.application.loader.FileAssetQueueLoader;
	import shipDock.framework.application.manager.LocaleManager;
	import shipDock.framework.core.queueExecuter.QueueExecuter;
	
	/**
	 * 游戏主类
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class IsKingStage extends Application 
	{
		
		public function IsKingStage() 
		{
			super();
			
		}
		
		private function loadFont():* {
			return SDCore.getInstance().assetManager.loadFont("assets/font/font.fnt");
		}
		
		override protected function setMainActionClass():void 
		{
			this._mainActionClass = MainAction;
		}
		
		override protected function start():void 
		{
			super.start();
			
			var queue:QueueExecuter = new QueueExecuter();
			
			var platformLoader:GamePlatformLoader = new GamePlatformLoader("platform.json");//平台参数加载器
			var localeManager:LocaleManager = LocaleManager.getInstance();//本地化管理器
			var gameChooseServer:GameChooseServer = new GameChooseServer();//游戏服务器选择器
			var gameVersion:GameVersion = new GameVersion();//游戏版本管理器
			var fileSyncer:GameFileSyncer = new GameFileSyncer();//游戏文件同步器
			var gameInitLoader:GameInitLoader = new GameInitLoader();//游戏初始化加载器
			var assetLoader:FileAssetQueueLoader = new FileAssetQueueLoader(["font_0", "icons"], AssetType.TYPE_PNG);
			
			queue.add(platformLoader);
			queue.add(localeManager);
			queue.add(gameChooseServer);
			queue.add(gameVersion);
			queue.add(fileSyncer);
			queue.add(assetLoader);
			queue.add(this.loadFont());
			queue.add(gameInitLoader);
			queue.add(this.startView);
			
			queue.start();
		}
		
		/**
		 * 开始界面
		 * 
		 */
		private function startView():void {
			(this.mainAction as MainAction).startView();
		}
	}

}