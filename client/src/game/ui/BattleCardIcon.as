package game.ui 
{
	import flash.geom.Point;
	
	import game.action.BattleCardIconAction;
	import game.command.BattleViewCommand;
	import game.model.BattleCardModel;
	import game.model.GeneralModel;
	import game.model.SkillModel;
	import game.notice.BattleViewNotice;
	import game.view.events.BattleCardEvent;
	
	import shipDock.framework.application.SDConfig;
	import shipDock.framework.application.SDCore;
	import shipDock.framework.application.component.SDComponent;
	import shipDock.framework.application.component.SDImage;
	import shipDock.framework.application.effect.AnimatableEffect;
	import shipDock.framework.application.effect.QueueEffect;
	import shipDock.framework.application.events.UIEvent;
	import shipDock.framework.application.manager.SDAssetManager;
	import shipDock.ui.View;
	
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 战斗牌图标
	 * 
	 * ...
	 * @author shaoxin.ji
	 */
	public class BattleCardIcon extends View 
	{
		
		private var _self:Array;
		private var _canClick:Boolean;
		private var _battleAction:BattleCardIconAction;
		
		public function BattleCardIcon() 
		{
			super();
			this._self = [this];
			this._UIConfigName = "battleCardIcon";
		}
		
		override protected function addEvents():void 
		{
			super.addEvents();
			this.addEventListener(TouchEvent.TOUCH, this.showBattleCardInfo);
			this.addEventListener(BattleCardEvent.BATTLE_CARD_ICON_READY_EVENT, this.iconReady);
		}
		
		override protected function removeEvents():void 
		{
			super.removeEvents();
			this.removeEventListener(TouchEvent.TOUCH, this.showBattleCardInfo);
			this.removeEventListener(BattleCardEvent.BATTLE_CARD_ICON_READY_EVENT, this.iconReady);
		}
		
		override protected function createUI():void 
		{
			super.createUI();
			
			this._battleAction = new BattleCardIconAction(this.name);
			this.setAction(this._battleAction);
		}
		
		override public function redraw():void 
		{
			super.redraw();
		}
		
		override protected function applyData():void 
		{
			super.applyData();
			if (this.isCreation) {
				this.setBattleCardIcon();
			}else {
				this.changePropertySet("data", true);
				this.invalidate();
			}
		}
		
		private function setBattleCardIcon():void {
			if (this.skillModel == null || this.generalModel == null) {
				return;
			}
			var assetManager:SDAssetManager = SDAssetManager.getInstance();
			var role:SDImage = assetManager.getImage(this.generalModel.middelImageID, false, true); 
			var skillIcon:SDImage = assetManager.getImage(this.skillModel.battleCardImage, false, true);
			
			role.alpha = 0;
			role.scaleX = 0.5;
			role.scaleY = 0.5;
			skillIcon.alpha = 0;
			skillIcon.scaleX = 0;
			skillIcon.scaleY = 0;
			this.getEmptySpriteUI("roleArea").addChild(role);
			this.getEmptySpriteUI("skillIconArea").addChild(skillIcon);
			
			this.putChildraw(role, "role");
			this.putChildraw(skillIcon, "skillIcon");
			
			if (this.isPropertySet("startReadyEffect", true)) {
				this.startReadyEffect();
			}
		}
		
		private function iconReady(event:BattleCardEvent):void {
			if (this._self.indexOf(event.data) != -1) {
				if (this.isCreation) {
					this.startReadyEffect();
				}else {
					this.changePropertySet("startReadyEffect", true);
				}
			}
		}
		
		private function startReadyEffect():void {
			var skillAlphaEffect:AnimatableEffect = new AnimatableEffect(this.skillIcon, 0.2, {"scaleX":0.5, "scaleY":0.5, "alpha":1} );
			var skillMoveEffect:AnimatableEffect = new AnimatableEffect(this, 0.2, {"x":this.targetPos.x, "y":this.targetPos.y, "delay":0.5} );
			var roleAlphaEffect:AnimatableEffect = new AnimatableEffect(this.role, 0.3, {"alpha":1} );
			var list:Array = [skillAlphaEffect, skillMoveEffect, roleAlphaEffect];
			var effect:QueueEffect = new QueueEffect(list);
			effect.complete = this.refillInellingence;
			effect.commit();
		}
		
		private function refillInellingence():void {
			this._battleAction.refillInellingence(this.ownerType);
		}
		
		private function showBattleCardInfo(event:TouchEvent):void {
			var battleCard:BattleCard;
			if (SDComponent.touchCheck(event, [TouchPhase.MOVED, TouchPhase.BEGAN])) {
				battleCard = this.getChildraw("battleCard") as BattleCard;
				if (battleCard == null) {
					battleCard = new BattleCard();
					battleCard.addEventListener(UIEvent.UI_DISPOSED_EVENT, this.battleCardDisposed);
					battleCard.addEventListener(BattleCardEvent.BATTLE_CARD_SHOWED_EVENT, this.battleCardShowed);
					this.putChildraw(battleCard, "battleCard");
				}
				battleCard.data = this.battleCardModel;
				SDCore.getInstance().gameApplication.tipLayer.addChild(battleCard);
				this.action.sendNotice(new BattleViewNotice(BattleViewCommand.STOP_BATTLE_TICS_COMMAND));
				
			}else if (SDComponent.touchCheck(event, TouchPhase.ENDED)) {
				this.battleCardRemove();
			}
		}
		
		private function battleCardRemove():void {
			var battleCard:BattleCard = this.getChildraw("battleCard") as BattleCard;
			if (battleCard != null) {
				battleCard.removeFromParent();
			}
			this.action.sendNotice(new BattleViewNotice(BattleViewCommand.RUN_BATTLE_TICS_COMMAND));
		}
		
		private function battleCardDisposed(event:Event):void {
			var battleCard:BattleCard = event.target as BattleCard;
			battleCard.removeEventListener(UIEvent.UI_DISPOSED_EVENT, this.battleCardDisposed);
			battleCard.removeEventListener(BattleCardEvent.BATTLE_CARD_SHOWED_EVENT, this.battleCardShowed);
		}
		
		private function battleCardShowed(event:BattleCardEvent):void {
			var battleCard:BattleCard = event.data as BattleCard;
			var cardX:Number = -battleCard.width / 4 * SDConfig.globalScale;
			var cardY:Number = this.y - (battleCard.height + this.height) * SDConfig.globalScale;
			var point:Point = new Point(cardX, cardY);
			point = this.localToGlobal(point);
			battleCard.x = point.x;// - battleCard.width / 4 * SDConfig.globalScale;
			battleCard.y = point.y - (battleCard.height + this.height * 2) * SDConfig.globalScale;;
		}
		
		private function get battleCardModel():BattleCardModel {
			return this.data["battleCardModel"];
		}
		
		private function get skillModel():SkillModel {
			return this.battleCardModel.skillModel;
		}
		
		private function get generalModel():GeneralModel {
			return this.battleCardModel.generalOwner;
		}
		
		private function get ownerType():int {
			return this.data["ownerType"];
		}
		
		private function get role():SDImage {
			return this.getChildraw("role") as SDImage;
		}
		
		private function get skillIcon():SDImage {
			return this.getChildraw("skillIcon") as SDImage;
		}
		
		private function get targetPos():Point {
			return this.data["targetPos"];
		}
	}

}