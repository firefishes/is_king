package game.notice 
{
	import game.command.BattleDataCommand;
	import game.notice.NoticeName;
	import game.utils.BattlePropertyName;
	
	/**
	 * 战场属性值蓄满消息
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattlePropertyFillNotice extends BattleDataSubjectNotice 
	{
		
		public function BattlePropertyFillNotice(ownerType:int, propertyName:String, isFillMax:Boolean = false) 
		{
			var data:Object = { "ownerType":ownerType, "isFillMax":isFillMax };
			switch(propertyName) {
				case BattlePropertyName.ANGER:
					data["isA"] = true;
					break;
				case BattlePropertyName.INTELLIGENCE:
					data["isI"] = true;
					break;
				case BattlePropertyName.MORALE:
					data["isM"] = true;
					break;
			}
			super(BattleDataCommand.BATTLE_PROPERTY_FILL_MAX_COMMAND, data);
			
			this.changeName(NoticeName.BATTLE_DATA);
		}
		
		public function get ownerType():int {
			return this.data["ownerType"];
		}
		
		public function get isAnger():Boolean {
			return this.data["isA"];
		}
		
		public function get isIntelligence():Boolean {
			return this.data["isI"];
		}
		
		public function get isMorale():Boolean {
			return this.data["isM"];
		}
		
		public function get isFillMax():Boolean {
			return this.data["isFillMax"];
		}
	}

}