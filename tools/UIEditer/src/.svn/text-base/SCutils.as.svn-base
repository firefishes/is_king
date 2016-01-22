package  
{
	import flash.data.SQLCollationType;
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.text.ReturnKeyLabel;
	
	/**
	 * ...
	 * @author HongSama
	 */
	public class SCutils 
	{
		static public var randCount:int = 0;
		static private var so:SharedObject;
		static private var fontArr:Object = new Object();
		static public var cache:Object = { };
		public function SCutils() 
		{
		}
		
		static public function getShareObject(name:String):*
		{
			if (!so)
			{
				SharedObject.preventBackup = true;
				so = SharedObject.getLocal(getSoAddr());
			}
			if (so.data[name])
			{
				return so.data[name];	
			}
			return null;
		}
		
		static public function addShareObject(name:String, data:*):void
		{
			if (!so)
			{
				so = SharedObject.getLocal(getSoAddr());
			}
			//trace(name,data);
			so.data[name] = data;
			so.flush();
		}
		
		static public function clearShareObject():void
		{
			if (!so)
			{
				so = SharedObject.getLocal(getSoAddr());
			}
			so.clear();
			so = null;
		}
		
		static private function getSoAddr():String
		{
			return "isKingUIParser";
		}
		
		
		static public function exitApplication():void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		/**
		 * 首字母大写
		 *  
		 * @param value
		 * @return 
		 * 
		 */
		public static function getFirstUpperCase(value:String):String{
			return (value.substr(0, 1).toUpperCase() + value.substr(1));
		}
		
		/**
		 * 首字母小写
		 *  
		 * @param value
		 * @return 
		 * 
		 */
		public static function getFirstLowerCase(value:String):String{
			return (value.substr(0, 1).toLowerCase() + value.substr(1));
		}
	}
}