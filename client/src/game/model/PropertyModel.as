package game.model
{
	import game.utils.PropertiesSetting;
	
	/**
	 * 属性数据模型
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class PropertyModel extends GameModel
	{
		
		private var _hp:Number;
		private var _atk:Number;
		private var _def:Number;
		private var _wit:Number;
		private var _warArt:Number;
		private var _troops:Number;
		
		public function PropertyModel(id:String = null)
		{
			super(id);
		
		}
		
		override public function updateData(data:Object):void 
		{
			super.updateData(data);
			var list:Array = PropertiesSetting.PROPERTIES;
			var keys:Array = PropertiesSetting.KEYS;
			for each(var property:* in list) {
				var index:int = list.indexOf(property);
				this.checkAndSet(keys[index], property, data);
			}
		}
		
		public function get hp():Number
		{
			return _hp;
		}
		
		public function set hp(value:Number):void
		{
			_hp = value;
		}
		
		public function get atk():Number
		{
			return _atk;
		}
		
		public function set atk(value:Number):void
		{
			_atk = value;
		}
		
		public function get def():Number 
		{
			return _def;
		}
		
		public function set def(value:Number):void 
		{
			_def = value;
		}
		
		public function get wit():Number 
		{
			return _wit;
		}
		
		public function set wit(value:Number):void 
		{
			_wit = value;
		}
		
		public function get warArt():Number 
		{
			return _warArt;
		}
		
		public function set warArt(value:Number):void 
		{
			_warArt = value;
		}
		
		public function get troops():Number 
		{
			return _troops;
		}
		
		public function set troops(value:Number):void 
		{
			_troops = value;
		}
	}

}