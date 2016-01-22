package game.model {
	import game.model.GameModel;
	import game.model.GeneralModel;
	import game.model.SkillModel;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleCardModel extends GameModel 
	{
		
		private var _ownerType:int;
		private var _cardIndex:int;
		private var _skillModel:SkillModel;
		
		public function BattleCardModel(id:String = null, ownerType:int = 0, skillModel:SkillModel = null) 
		{
			this._ownerType = ownerType;
			this._skillModel = skillModel;
			super(id);
			
		}
		
		public function setOwnerType(value:int):void {
			this._ownerType = value;
		}
		
		override protected function initModel():void 
		{
			super.initModel();
			
			this.setName(this._skillModel.name);
			this.setDecs(this._skillModel.decs);
		}
		
		public function get generalOwner():GeneralModel {
			return (this._skillModel != null) ? this._skillModel.generalModel : null;
		}
		
		public function get skillModel():SkillModel 
		{
			return _skillModel;
		}
		
		public function get cardIndex():int 
		{
			return _cardIndex;
		}
		
		public function set cardIndex(value:int):void 
		{
			_cardIndex = value;
		}
		
		public function get ownerType():int 
		{
			return _ownerType;
		}
	}

}