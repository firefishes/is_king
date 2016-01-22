package  
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author HongSama
	 */
	public class QueueLoader extends URLLoader 
	{
		
		private var urlRequest:URLRequest;
		public function QueueLoader(url:String) 
		{
			urlRequest = new URLRequest(url);
			super();
		}
		
		public function commit():void
		{
			load(urlRequest);
		}
	}
}