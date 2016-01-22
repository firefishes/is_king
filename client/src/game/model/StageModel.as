package game.model 
{
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class StageModel extends GameModel 
	{
		
		private var _enemyList:Array;
		
		public function StageModel(id:String=null) 
		{
			super(id);
			
		}
		
		override protected function initModel():void 
		{
			super.initModel();
			
			this._enemyList = [
				new GeneralModel("100009"),
				new GeneralModel("100010"),
				new GeneralModel("100011"),
				new GeneralModel("100012"),
				new GeneralModel("100013"),
				new GeneralModel("100014"),
				new GeneralModel("100015"),
				new GeneralModel("100016"),
			];
		}
		
		public function get enemyList():Array 
		{
			return _enemyList;
		}
		
	}

}