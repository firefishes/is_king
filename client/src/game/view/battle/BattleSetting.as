package game.view.battle
{
	import flash.geom.Point;
	
	import shipDock.framework.application.manager.ConfigManager;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleSetting
	{
		
		public static const BATTLE_FRAME_RATE:int = 60;//战斗帧频
		
		public static const ROW_MAX:int = 5;//战场单元格行数
		public static const COLUMN_MAX:int = 10;//战场单元格列数
		
		public static const DAY_NIGHT_CHANGE_TIME_SECS:Number = 60; //变天周期的秒数
		
		public static const ANGER_INIT:int = 0; //怒气初始值
		public static const MORALE_INIT:int = 50; //士气初始值
		public static const INTELLIGENCE_INIT:int = 50; //情报初始值
		
		public static const INTELLIGENCE_CHANGED:int = 10; //情报初始改变值
		
		public static const ANGER_CYCLE_INIT:int = 200; //士气变化周期初始值
		public static const MORALE_CYCLE_INIT:int = 200; //士气变化周期初始值
		public static const INTELLIGENCE_CYCLE_INIT:int = 20; //情报变化周期初始值
		
		public static const MORALE_MAX:int = 100; //士气最大值
		public static const BATTLE_CARD_MAX:int = 7;
		
		public static var gridLayerOffsetPoint:Point;//战场单元格坐标修正坐标
		
		private static var battleGeneralSite:Object;//战场单元格表示的将领战阵位置配置
		
		private static var isInitUserSite:Boolean;//玩家将领战争位置是否初始化
		private static var isInitEnemySite:Boolean;//对方将领战争位置是否初始化
		
		public static function getBattleGeneralSite(battleSiteName:int, isUser:Boolean = true):Point
		{
			var flagName:String = (isUser) ? "u" : "e";
			(!battleGeneralSite) && (battleGeneralSite = ConfigManager.getInstance().getConfig("battleGeneralSite"));
			var result:Object = battleGeneralSite[flagName + "_" + battleSiteName];
			return new Point(result.x, result.y);
		}
		
		public function BattleSetting()
		{
		
		}
	
	}

}