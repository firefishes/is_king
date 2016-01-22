package game.utils 
{
	import game.model.GeneralModel;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleDataUtils 
	{
		
		public static function getBattleAngerMax(list:Array):Number {
			var i:int = 0;
			var max:int = list.length;
			var total:Number = 0;
			var count:int = 0;
			while (i < max) {
				var general:GeneralModel = list[i];
				if (general != null) {
					total += general.atk;
					count++;
				}
				i++;
			}
			return Math.round(total / count);//暂时用平均数计算
		}
		
		public static function getBattleIntelligenceMax(list:Array):Number {
			var i:int = 0;
			var max:int = list.length;
			var total:Number = 0;
			var count:int = 0;
			while (i < max) {
				var general:GeneralModel = list[i];
				if (general != null) {
					total += general.wit;
					count++;
				}
				i++;
			}
			return Math.round(total / count);//暂时用平均数计算
		}
		
		public function BattleDataUtils() 
		{
			
		}
		
	}

}