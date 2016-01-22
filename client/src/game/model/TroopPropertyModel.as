package game.model 
{
	import game.utils.PropertiesSetting;
	/**
	 * 部队属性数据对象类
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class TroopPropertyModel extends GameModel 
	{
		
		private var _march:Number;//行军
		private var _raid:Number;//奇袭
		private var _garrison:Number;//驻守
		private var _mass:Number;//集结
		
		private var _baseProperty:PropertyModel;
		
		public function TroopPropertyModel(id:String=null) 
		{
			this._baseProperty = new PropertyModel(this.id);
			super(id);
			
		}
		
		override public function updateData(data:Object):void 
		{
			super.updateData(data);
			this.updateTroopData(data);
			this._baseProperty.updateData(data);
		}
		
		private function updateTroopData(data:Object):void {
			var keys:Array = PropertiesSetting.TROOP_KEYS;
			var list:Array = PropertiesSetting.TROOP_PROPERTIES;
			var i:int = 0;
			var max:int = list.length;
			while (i < max) {
				this.checkAndSet(keys[i], list[i], data);
				i++;
			}
		}
		
		public function get atk():Number {
			return this._baseProperty.atk;
		}
		
		public function get def():Number {
			return this._baseProperty.def;
		}
		
		public function get hp():Number {
			return this._baseProperty.hp;
		}
		
		override public function get quality():int {
			return this._baseProperty.quality;
		}
		
		public function get march():Number 
		{
			return _march;
		}
		
		public function get raid():Number 
		{
			return _raid;
		}
		
		public function get garrison():Number 
		{
			return _garrison;
		}
		
		public function get mass():Number 
		{
			return _mass;
		}
	}

}