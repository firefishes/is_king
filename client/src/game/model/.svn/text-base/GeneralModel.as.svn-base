package game.model 
{
	import game.IsKingSetting;
	import game.utils.SkillType;
	import shipDock.framework.application.manager.LocaleManager;
	/**
	 * 将领数据模型
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class GeneralModel extends PropertyModel 
	{
		
		private var _smallImageID:String;
		private var _middelImageID:String;
		private var _largeImageID:String;
		
		private var _weaponImageID:String;
		
		private var _leaderSkillID:String;
		private var _roleSkillIDs:Array;
		private var _battleSkillIDs:Array;
		
		public function GeneralModel(id:String) 
		{
			super(id);
			
		}
		
		override public function updateData(data:Object):void 
		{
			super.updateData(data);
		}
		
		override protected function initModel():void 
		{
			super.initModel();
			this._modelData = this.getModelConfig(ConfigName.GENERAL_CONFIG, this.id);
			this._largeImageID = this.id + "_0";
			this._middelImageID = this.id + "_1";
			this._smallImageID = this.id + "_2";
			this._weaponImageID = this.id + "_3";
			this.setName(LocaleManager.getInstance().getText(this._modelData["name"]));
			trace(this.name);
			super.updateData(this._modelData);
			
			var skillConfig:Object;
			var generalSkillRelation:Object = this.getModelConfig(ConfigName.GENERAL_SKILL_RELATION_CONFIG, this.id);//将领与技能的关联配置
			
			this._roleSkillIDs = [];
			this._battleSkillIDs = [];
			
			var i:int = 0;
			var max:int = IsKingSetting.GENERAL_SKILL_MAX;
			while (i < max) {
				var key:String = IsKingSetting.CONFIG_KEY_SKILL_ID + (i + 1);
				var skillID:String = generalSkillRelation[key];
				if(skillID != IsKingSetting.CONFIG_KEY_NO_RELATION) {
					skillConfig = this.getModelConfig(ConfigName.SKILL_CONFIG, skillID);//技能配置
					var skillType:int = skillConfig["skill_type"];
					if (skillType == SkillType.SKILL_TYPE_COACH) {//主帅技
						this._leaderSkillID = skillID;
						
					}else if (skillType == SkillType.SKILL_TYPE_ROLE) {//人物技
						this._roleSkillIDs.push(skillID);
						
					}/*else if (skillType == SkillType.SKILL_TYPE_ADVISER) {//军师技
						this._battleSkillIDs.push(skillID);
					}*/
				}
				i++;
			}
		}
		
		public function get smallImageID():String 
		{
			return _smallImageID;
		}
		
		public function get middelImageID():String 
		{
			return _middelImageID;
		}
		
		public function get largeImageID():String 
		{
			return _largeImageID;
		}
		
		override public function get assetID():String 
		{
			return "img_" + this.id;
		}
		
		public function get leaderSkillID():String 
		{
			return _leaderSkillID;
		}
		
		public function get roleSkillIDs():Array 
		{
			return _roleSkillIDs;
		}
		
		public function get battleSkillIDs():Array 
		{
			return _battleSkillIDs;
		}
		
	}

}