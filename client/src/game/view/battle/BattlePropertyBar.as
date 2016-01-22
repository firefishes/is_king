package game.view.battle 
{
	import shipDock.ui.DirectionType;
	import shipDock.ui.ProgressClippedBar;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BattlePropertyBar extends ProgressClippedBar 
	{
		
		public function BattlePropertyBar(width:Number, height:Number, progress:*, offsetX:Number=0, offsetY:Number=0, border:*=null, bg:*=null, onUpdate:Function=null, rotation:Number=0) 
		{
			super(width, height, progress, offsetX, offsetY, border, bg, onUpdate, rotation);
			this.direction = DirectionType.VERTICAL;
		}
		
		override protected function initClip():void 
		{
			super.initClip();
			this.clip.y = this.progressHeight;
			this.clip.scaleY = -1;
		}
		
		override protected function initBar(value:*):void 
		{
			super.initBar(value);
			this._bar.y = this._bar.height;
			this._bar.scaleY = -1;
		}
	}

}