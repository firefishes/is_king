package mapEditer
{
	import game.view.battle.BattleGridLayer;
	
	/**
	 * ...
	 * @author ch.ji
	 */
	public class MapEditerGrid extends BattleGridLayer
	{
		
		public function MapEditerGrid(x:Number, y:Number, row:int, colum:int, w:Number, h:Number)
		{
			super(x, y, row, colum, w, h);
		
		}
		
		public function get gridSize():int
		{
			return this.row * this.column;
		}
	
	}

}