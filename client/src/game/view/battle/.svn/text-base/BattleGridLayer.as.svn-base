package game.view.battle 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleGridLayer 
	{
		
		private var _x:Number;
		private var _y:Number;
		private var _row:int;
		private var _column:int;
		private var _gridWidth:Number;
		private var _gridHeight:Number;
		
		private var _width:Number;
		private var _height:Number;
		
		public function BattleGridLayer(x:Number, y:Number, row:int, colum:int, w:Number, h:Number) 
		{
			this._width = w;
			this._height = h;
			this._row = row;
			this._column = colum;
			this._gridWidth = this._width / colum;
			this._gridHeight = this._height / row;
		}
		
		public function getGridByPos(x:Number, y:Number):Point {
			var row:int = int(y / this._gridHeight); 
			var column:int = int(x / this._gridWidth);
			return new Point(column, row);
		}
		
		/**
		 * y等效于row
		 * 
		 * @param	row
		 * @param	column
		 * @return
		 */
		public function getPosByGrid(row:Number, column:Number):Point {
			var x:int = column * this._gridWidth; 
			var y:int = row * this._gridHeight;
			return new Point(BattleSetting.gridLayerOffsetPoint.x + x, BattleSetting.gridLayerOffsetPoint.y + y);
		}
		
		public function get gridWidth():Number 
		{
			return _gridWidth;
		}
		
		public function get gridHeight():Number 
		{
			return _gridHeight;
		}
		
	}

}