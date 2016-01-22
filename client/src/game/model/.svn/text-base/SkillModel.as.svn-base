package game.model 
{
	import shipDock.framework.application.manager.ConfigManager;
	import shipDock.framework.application.manager.LocaleManager;
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class SkillModel extends GameModel 
	{
		
		private var _skillType:int;//技能大类
		private var _skillSubType:int;//技能子分类
		
		private var _skillEffectDecs:String;
		private var _battleCardImage:String;
		private var _generalModel:GeneralModel;
		
		public function SkillModel(id:String=null, generalModel:GeneralModel = null) 
		{
			this._generalModel = generalModel;
			super(id);
			
		}
		
		override protected function initModel():void 
		{
			super.initModel();
			
			var skillConfig:Object = ConfigManager.getInstance().getConfig(ConfigName.SKILL_CONFIG);
			skillConfig = skillConfig[this.id];
			
			var localeManager:LocaleManager = LocaleManager.getInstance();
			this.setName(localeManager.getText(skillConfig["name"]));
			this.setDecs(localeManager.getText(skillConfig["decs"]));
			this.setQuality(skillConfig["quality"]);
			
			var content:String = LocaleManager.getInstance().getText(skillConfig["effect_decs"]);
			var who:String = (this._generalModel != null) ? this._generalModel.name : localeManager.getText("skill_owner");
			content = content.replace(new RegExp("\\{skill_who\\}", '*g'), who);
			content = content.replace(new RegExp("\\{skill_item_0\\}", '*g'), " " + localeManager.getText("skill_item_0"));
			content = content.replace(new RegExp("\\{skill_item_1\\}", '*g'), " " + localeManager.getText("skill_item_1"));
			content = content.replace(new RegExp("\\{skill_item_2\\}", '*g'), " " + localeManager.getText("skill_item_2"));
			this._skillEffectDecs = content;
			
			this._battleCardImage = "battle_image_" + this.id;
			
			this._skillType = skillConfig["skill_type"];
			this._skillSubType = skillConfig["sub_type"];
		}
		
		public function setGeneralModel(value:GeneralModel):void {
			this._generalModel = value;
		}
		
		public function get skillEffectDecs():String 
		{
			return _skillEffectDecs;
		}
		
		public function get battleCardImage():String 
		{
			return _battleCardImage;
		}
		
		public function get skillType():int 
		{
			return _skillType;
		}
		
		public function get skillSubType():int 
		{
			return _skillSubType;
		}
		
		public function get generalModel():GeneralModel 
		{
			return _generalModel;
		}
		
	}

}