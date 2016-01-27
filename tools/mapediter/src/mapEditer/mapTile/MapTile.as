package mapEditer.mapTile 
{
	import flash.display.Sprite;
	
	/**
	 * 地图单元格
	 * 
	 * ...
	 * @author ch.ji
	 */
	public class MapTile extends Sprite 
	{
		
		public function MapTile(w:Number, h:Number) 
		{
			super();
			
			this.graphics.lineStyle(1);
			this.graphics.beginFill(0, 0.8);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			
		}
		
	}

}