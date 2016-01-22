package  
{
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class DataLoader extends QueueLoader
	{
		
		public static const DATA_TYPE_JSON:int = 0;
		public static const DATA_TYPE_BINAY:int = 1;
		
		private var _dataType:int = 0
		private var _loadCompleted:Function;
		private var _loadProgress:Function;
		private var _loadedData:*;
		
		public function DataLoader(url:String, complete:Function = null, progress:Function = null) 
		{
			super(url);
			this._loadCompleted = complete;
			this._loadProgress = progress;
			this.addEvents();
		}
		
		override public function commit():void 
		{
			if (this._dataType == DATA_TYPE_JSON) {
				this.dataFormat = URLLoaderDataFormat.TEXT;
			}else if (this._dataType == DATA_TYPE_BINAY) {
				this.dataFormat = URLLoaderDataFormat.BINARY;
			}
			super.commit();
		}
		
		public function dispose():void {
			this.removeEvents();
			this._loadCompleted = null;
			this._loadProgress = null;
		}
		
		protected function loadCompleteHandler(event:Event):void {
			if (this._loadCompleted != null) {
				this._loadedData = this.data;
				if (this._dataType == DATA_TYPE_JSON) {
					this._loadedData = JSON.parse(this.data);
					
				}
				this._loadCompleted(this._loadedData);
			}
		}
		
		protected function openHandler(event:Event):void {
			
		}
		
		protected function loadProgressHandler(event:ProgressEvent):void {
			if (this._loadProgress != null) {
				this._loadProgress(event);
			}
		}
		
		protected function httpStatusHandler(event:HTTPStatusEvent):void {
			
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void {
			
		}
		
		/**
		 * 添加事件 
		 * 
		 */
		private function addEvents():void {
			this.addEventListener(Event.COMPLETE, loadCompleteHandler);
			this.addEventListener(Event.OPEN, openHandler);
			this.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			this.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			this.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * 移除事件 
		 * 
		 */
		private function removeEvents():void {
			this.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			this.removeEventListener(Event.OPEN, openHandler);
			this.removeEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			this.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			this.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		public function get dataType():int 
		{
			return _dataType;
		}
		
		public function set dataType(value:int):void 
		{
			_dataType = value;
		}
		
		public function get loadedData():* 
		{
			return _loadedData;
		}
		
	}

}