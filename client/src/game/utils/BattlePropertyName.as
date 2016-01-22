package game.utils 
{
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattlePropertyName 
	{
		/*兵力*/
		public static const TROOPS:String = "troops";
		/*怒气*/
		public static const ANGER:String = "anger";
		/*士气*/
		public static const MORALE:String = "morale";
		/*情报*/
		public static const INTELLIGENCE:String = "intelligence";
		/*兵力最大值*/
		public static const TROOPS_MAX:String = "troopsMax";
		/*怒气最大值*/
		public static const ANGER_MAX:String = "angerMax";
		/*士气最大值*/
		public static const MORALE_MAX:String = "moraleMax";
		/*情报最大值*/
		public static const INTELLIGENCE_MAX:String = "intelligenceMax";
		/*怒气增量*/
		public static const ANGER_CHANGED:String = "angerChanged";
		/*士气增量*/
		public static const MORALE_CHANGED:String = "moraleChanged";
		/*情报增量*/
		public static const INTELLIGENCE_CHANGED:String = "_intelligenceChanged";
		/*怒气变化周期*/
		public static const ANGER_CYCLE:String = "angerCycle";
		/*士气变化周期*/
		public static const MORALE_CYCLE:String = "moraleCycle";
		/*情报变化周期*/
		public static const INTELLIGENCE_CYCLE:String = "intelligenceCycle";
		/*怒气变化周期当前值*/
		public static const ANGER_CYCLE_CURRENT:String = "angerCycleCurrent";
		/*士气变化周期当前值*/
		public static const MORALE_CYCLE_CURRENT:String = "moraleCycleCurrent";
		/*情报变化周期当前值*/
		public static const INTELLIGENCE_CYCLE_CURRENT:String = "intelligenceCycleCurrent";
		
		public static const BATTLE_PROPERTY_LIST:Array = [ANGER, MORALE, INTELLIGENCE];
		
		public function BattlePropertyName() 
		{
			
		}
		
	}

}