package game.model 
{
	import game.utils.GeneralSiteName;
	
	/**
	 * 阵地数据
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class PositionsModel extends GameModel 
	{
		private var _isClone:Boolean;
		private var _positionsList:Array;
		private var _generalCount:int;
		
		public function PositionsModel(name:String) 
		{
			super(name);
			
			this._positionsList = new Array(GeneralSiteName.SITE_MAX);
			var i:int = 0;
			var max:int = this._positionsList.length;
			while(i < max) {
				this._positionsList[i] = null;
				i++;
			}
		}
		
		public function setGeneralList(list:Array, isClone:Boolean = true):void {
			this._isClone = isClone;
			this._positionsList = (isClone) ? list.concat() : list;
		}
		
		public function setGeneral(siteName:int, value:GeneralModel):void {
			this._positionsList[siteName] = value;
		}
		
		public function getGeneral(siteName:int):GeneralModel {
			return this._positionsList[siteName];
		}
		
		public function get positionsList():Array 
		{
			return _positionsList;
		}
		
		public function get isClone():Boolean 
		{
			return _isClone;
		}
		
		public function get generalCount():int {
			if (isNaN(this._generalCount)) {
				for each(var v:* in this._positionsList) {
					if (v != null) {
						this._generalCount++;
					}
				}
			}
			return this._generalCount;
		}
	}

}