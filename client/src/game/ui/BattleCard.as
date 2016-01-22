package game.ui 
{
	import game.model.BattleCardModel;
	import game.model.GeneralModel;
	import game.model.SkillModel;
	import game.view.events.BattleCardEvent;
	
	import shipDock.framework.application.SDConfig;
	import shipDock.framework.application.component.SDImage;
	import shipDock.framework.application.component.SDSprite;
	import shipDock.framework.application.manager.SDAssetManager;
	import shipDock.framework.application.utils.DisplayUtils;
	import shipDock.ui.View;
	
	/**
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleCard extends View 
	{
		
		private var _cardContainer:SDSprite;
		
		public function BattleCard() 
		{
			super();
			this._UIConfigName = "battleCard";
		}
		
		override protected function createUI():void 
		{
			super.createUI();
		}
		
		override public function redraw():void 
		{
			super.redraw();
		}
		
		override protected function applyData():void 
		{
			super.applyData();
			if (this.isCreation) {
				this.setCard();
			}else {
				this.changePropertySet("data", true);
				this.invalidate();
			}
		}
		
		private function setCard():void {
			if (this.skillModel == null || this.generalModel == null) {
				return;
			}
			var assetManager:SDAssetManager = SDAssetManager.getInstance();
			var bg:SDImage = assetManager.getImage("battleCardBg" + this.skillModel.quality, false, true);
			var role:SDImage = assetManager.getImage(this.generalModel.middelImageID, false, true); 
			var skillIcon:SDImage = assetManager.getImage(this.skillModel.battleCardImage, false, true);
			var typeIcon:SDImage = assetManager.getImage("skill_sub_type_" + this.skillModel.skillSubType, false, true);
			
			role.scaleX = 0.7;
			role.scaleY = 0.7;
			role.alpha = 0.5;
			
			if (this._cardContainer == null) {
				this._cardContainer = new SDSprite();
			}
			this.addChildToContainer(bg, "cardBgArea", this._cardContainer);
			this.addChildToContainer(role, "roleArea", this._cardContainer);
			this.addChildToContainer(skillIcon, "skillIconArea", this._cardContainer);
			this.addChildToContainer(typeIcon, "subTypeArea", this._cardContainer);
			
			this.addChildAt(this._cardContainer, this.numChildren - 2);
			
			DisplayUtils.rePivot(this);
			this._cardContainer.x += this._cardContainer.width / 2 * SDConfig.globalScale;
			this._cardContainer.y += this._cardContainer.height / 2 * SDConfig.globalScale;
			
			this.getTextUI("skillName").x += this._cardContainer.width / 2 * SDConfig.globalScale;
			this.getTextUI("skillName").y += this._cardContainer.height / 2 * SDConfig.globalScale;
			this.getTextUI("effectDecs").x += this._cardContainer.width / 2 * SDConfig.globalScale;
			this.getTextUI("effectDecs").y += this._cardContainer.height / 2 * SDConfig.globalScale;
			this.getTextUI("skillName").multiLine = true;
			this.getTextUI("effectDecs").multiLine = true;
			this.setStaticTextValue("skillName", "text", this.skillModel.name);
			this.setStaticTextValue("effectDecs", "text", this.skillModel.skillEffectDecs);
			this.commitStaticTextsChanged();
			
			this.dispatchEvent(new BattleCardEvent(BattleCardEvent.BATTLE_CARD_SHOWED_EVENT, this));
		}
		
		private function get battleCardModel():BattleCardModel {
			return this.data as BattleCardModel;
		}
		
		private function get skillModel():SkillModel {
			return battleCardModel.skillModel;
		}
		
		private function get generalModel():GeneralModel {
			return battleCardModel.generalOwner;
		}
	}

}