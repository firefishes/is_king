package game.model 
{
	import shipDock.framework.application.manager.ConfigManager;
	import shipDock.framework.core.model.DataModel;
	/**
	 * 游戏数据模型基类
	 * 
	 * ...
	 * @author ch.ji
	 */
	public class GameModel extends DataModel 
	{
		
		private var _stockID:String;
		private var _decs:String;
		private var _quality:int = 0;
		
		protected var _modelData:Object;
		
		public function GameModel(id:String = null) 
		{
			this.id = id;
			super();
		}
		
		override public function dispose():void 
		{
			super.dispose();
			this._modelData = null;
		}
		
		protected function setQuality(value:int):void {
			_quality = value;
		}
		
		protected function setDecs(value:String):void {
			this._decs = value;
		}
		
		protected function initModel():void {
			
		}
		
		protected function getModelConfig(configName:String, key:String):Object {
			var config:Object = ConfigManager.getInstance().getConfig(configName);
			var result:Object = (config != null) ? config[key] : null;
			return result;
		}
		
		override public function set id(value:String):void 
		{
			super.id = value;
			this.initModel();
		}
		
		public function get assetID():String {
			return null;
		}
		
		public function get stockID():String 
		{
			return _stockID;
		}
		
		public function set stockID(value:String):void 
		{
			_stockID = value;
		}
		
		public function get decs():String 
		{
			return _decs;
		}
		
		public function get quality():int 
		{
			return _quality;
		}
		
	}

}