package game.notice 
{
	import game.command.BattleDataCommand;
	import game.command.BattleOptionPannelCommand;
	import game.command.BattleViewCommand;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattlePropertyChangedNotice extends BattleOptionPannelNotice 
	{
		
		/**
		 * 
		 * @param	key 属性字段名，位于 BattlePropertyName 中
		 * @param	value 修改后的值
		 * @param	changed 从原值到当前值的改变量
		 * @param	ownerType 属性所在的势力，位于 BattleOwner 中
		 */
		public function BattlePropertyChangedNotice(key:String, value:Number, changed:Number = 0, max:Number = 0, ownerType:int = -1) 
		{
			super(BattleOptionPannelCommand.BATTLE_PROPERTY_CHANGED_COMMAND, {"k":key, "v":value, "c":changed, "m":max, "o":ownerType});
			
		}
		
		public function get changed():Number {
			return this.data["c"];
		}
		
		public function get propertyName():String {
			return this.data["k"];
		}
		
		public function get propertyValue():Number {
			return this.data["v"];
		}
		
		public function get ownerType():int {
			return this.data["o"];
		}
		
		public function get propertyMax():Number {
			return this.data["m"];
		}
		
	}

}