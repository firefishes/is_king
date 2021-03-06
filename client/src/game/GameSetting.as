package game 
{
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class GameSetting 
	{
		
		public static const FILE_ASSET:String = "assets/";
		public static const FILE_CONFIG:String = "config/";
		public static const FILE_LOCALE:String = "locale/";
		public static const FILE_VIEW:String = "view/";
		
		private static const HOST:String = "http://127.0.0.1/isKing/";//服务器地址
		private static const ASSET:String = HOST + FILE_ASSET;
		
		public static const APP_VERSION:String = "2.0.0";
		public static const PLATFORM:String = "app_store";
        public static const TOKEN:String = "iphone";
		
		public static const USER_TOKEN:String = "fuck250";//验证用户登录，经平台或服务端转换后的id
		public static const USER_SIGN:String = "fuck250";//用户id，与token用于平台验证
		
		public static const GAME_OS_NAME:String = "isKing";
		
		public static var debug:Boolean;
		public static var resourceListType:int;
		public static var applyAssetServer:Boolean;
		
		private static var hostValue:String;//当前服务器地址
		private static var assetValue:String;//当前素材地址
		
		public static function get asset():String {
			if (assetValue == null) {
				assetValue = (applyAssetServer) ? ASSET : FILE_ASSET;
			}
			return assetValue;
		}
		
		public static function get host():String {
			if (hostValue == null) {
				hostValue = HOST;
			}
			return hostValue;
		}
		
		public function GameSetting() 
		{
			
		}
		
	}

}